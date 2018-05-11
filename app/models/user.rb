# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  guid                   :string(255)
#  nickname               :string(255)
#  dob                    :integer
#  firstname              :string(255)
#  lastname               :string(255)
#  gender                 :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  local                  :string(255)
#  email                  :string(255)      default(""), not null
#  facebook_id            :string(255)
#  ipaddress              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  cover_image_uid        :string(255)
#  cover_image_name       :string(255)
#  bg_image_uid           :string(255)
#  bg_image_name          :string(255)
#  bio                    :text
#  sport                  :string(255)
#  team_name              :string(255)
#  box_pos                :string(255)      default("right")
#  box_text_col           :string(255)      default("E2DFDD")
#  field_pos              :string(255)
#  school_name            :string(255)
#  box_bg_color           :string(255)
#  theme                  :string(255)
#  is_admin               :boolean
#  is_active              :boolean
#  align_landscape        :string(255)      default("top center")
#  align_portrait         :string(255)      default("center center")
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  profile_image          :string(255)
#  background_image       :string(255)
#  is_invited             :boolean
#  favorite_athletes      :text
#  favorite_teams         :text
#  teamurl                :string(255)
#  avatar_tiny_uid        :string(255)
#  bg_full_uid            :string(255)
#  psi_image_med_uid      :string(255)
#  psi_image_framed_uid   :string(255)
#  bgimg                  :string(255)
#  profileimg             :string(255)
#  qrcode                 :string(255)
#  jersey_num             :integer
#  height                 :string(255)
#  weight                 :string(255)
#

class User < ActiveRecord::Base

  # scope :open_print_order, where(to_print: true)

 #Friendship Association
	has_many :friendships
 	has_many :friends, :through => :friendships

 #Followship Association
  has_many :followships, :dependent 	=> :destroy,
 		  	   :foreign_key => "follower_id"

	has_many :reverse_followships, 	:dependent 	=> :destroy,
 			  	 :foreign_key => "followed_id",
 			  	 :class_name => "Followship"

 	has_many :following, :through => :followships,
 					 :source => :followed

 	has_many :followers,:through => :reverse_followships,
 					 :source => :follower

  has_many :photos, 	:dependent 	=> :destroy
  has_many :comments, :dependent 	=> :destroy

  has_many :wishings
  has_many :wishes, :through => :wishings,
           :source => :product

  has_many :football_stats,   :dependent  => :destroy
  has_many :baseball_stats,   :dependent  => :destroy
  has_many :basketball_stats,   :dependent  => :destroy
  has_many :soccer_stats,   :dependent  => :destroy

  has_many :collectibles,   :dependent  => :destroy


  has_one  :mvp_survey

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :city, :country, :dob, :email, :facebook_id, :firstname, :gender, :ipaddress, :lastname, :local, :nickname, :state
  attr_accessible :cover_image, :bg_image, :bio, :sport, :team_name, :box_pos, :box_text_col, :field_pos, :school_name, :box_bg_color
  attr_accessible :theme, :align_landscape, :align_portrait, :teamurl, :bgimg, :profileimg, :remote_bgimg_url, :height, :weight, :remote_qrcode_url

  mount_uploader :bgimg, BgimgUploader
  mount_uploader :profileimg, ProfileimgUploader
  mount_uploader :qrcode, QrcodeUploader


  serialize :favorite_athletes, JSON
  serialize :favorite_teams, JSON



  image_accessor :cover_image do
    storage_path{|a| "users/#{self.guid}/cover/#{rand(100)}-#{a.name}" }
  end

  image_accessor :bg_image do
    storage_path{|a| "users/#{self.guid}/bg/#{rand(100)}-#{a.name}" }
  end

  image_accessor :psi_image_med do
    storage_path{|a| "users/#{self.guid}/bg/#{rand(100)}-#{a.name}" }
  end

  image_accessor :psi_image_framed do
    storage_path{|a| "users/#{self.guid}/bg/#{rand(100)}-#{a.name}" }
  end

  image_accessor :avatar_tiny do
    storage_path{|a| "users/#{self.guid}/cover/#{rand(100)}-#{a.name}" }
  end



  # Virtual Attributes
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :crop_iw, :crop_ih


  before_save :set_guid #, :update_cover_related_thumbs, :update_bg_related_thumbs
  # after_save :setQRcode

  def crop_bgimg
    if crop_x.present?
      bgimg.cache_stored_file!
      bgimg.retrieve_from_cache!(bgimg.cache_name)
      bgimg.recreate_versions!
    end
  end


	def self.from_omniauth(auth)
		 #raise auth.to_yaml
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      # Gets updated everytime user logs back in

	    user.provider = auth.provider
	    user.uid = auth.uid
      user.facebook_id = auth.uid
	    user.nickname = auth.info.nickname
	    user.firstname = auth.info.first_name if user.firstname.blank?
	    user.lastname = auth.info.last_name if user.lastname.blank?
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      if !auth.info.email.nil?
        user.email = auth.info.email
      else
        user.email = "nullemail@#{auth.uid}.com"
      end

      user.favorite_teams = auth.extra.raw_info.favorite_teams.map { |x| {name: x.name.gsub(/\"/,"'"), id: x.id} }  if !auth.extra.raw_info.favorite_teams.nil?
      user.favorite_athletes = auth.extra.raw_info.favorite_athletes.map { |x| {name: x.name.gsub(/\"/,"'"), id: x.id} } if !auth.extra.raw_info.favorite_athletes.nil?
      user.save!
	  end
	end

  def create_from_facebook(fb_id)
    user = User.find_by_facebook_id fb_id
    if user.nil?
    # Fetch min info on user from facebook and create user
      @graph = Koala::Facebook::API.new(self.oauth_token)
      fbuser = @graph.get_object(fb_id)
      # puts fbuser
      unless fbuser.nil?
        user = User.new
        user.provider = 'facebook'
        user.uid = fb_id
        user.facebook_id = fb_id
        user.nickname = fbuser["username"]
        user.firstname = fbuser["first_name"] if user["firstname"].blank?
        user.lastname = fbuser["last_name"] if user["lastname"].blank?
        user.gender = fbuser["gender"] if user["gender"].blank?
        user.email = "nullemail@#{fbuser['username']}.com"

        user.save!
        return user
      end
    else
      return user
    end
  end

  def getSportsFav
     @graph = Koala::Facebook::API.new(self.oauth_token)
     res = @graph.get_object("me?fields=favorite_athletes,favorite_teams")
     puts res
  end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
	end

	def password_required?
	  super && provider.blank?
	end

	def email_required?
	  super && provider.blank?
	end

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end


  def getAvatar
    begin
        if !self.profileimg.blank?
          image = self.profileimg_url(:avatar)
        elsif self.provider == 'facebook'
            "https://graph.facebook.com/#{self.uid}/picture?width=212&height=230"   # TODO need to add a default image
        else
            "/assets/missing_image.jpg"
        end
    rescue
      "/assets/missing_img.jpg"
    end

  end



  def getAvatarThumb
    begin
      if !self.profileimg.blank?
          image = self.profileimg_url(:thumb)
          elsif self.provider == 'facebook'
          "https://graph.facebook.com/#{self.uid}/picture?width=35&height=35"
      else
          "/assets/missing_image.jpg"
      end
    rescue Exception => exc
      "/assets/missing_img.jpg"
    end

  end

  def getAvatarSq_med
    begin
        if !self.profileimg.blank?
            image = self.profileimg_url(:sq_med)
            elsif self.provider == 'facebook'
            "https://graph.facebook.com/#{self.uid}/picture?width=100&height=100"
        else
            "/assets/missing_image.jpg"
        end
      rescue Exception => exc
        "/assets/missing_img.jpg"
      end
  end


  def getAvatarSmall
    begin
        if !self.profileimg.blank?
          image = self.profileimg_url(:sq_sml)
        elsif self.provider == 'facebook'
          "https://graph.facebook.com/#{self.uid}/picture?width=50&height=50"
        else
            "/assets/missing_image.jpg"
        end
      rescue Exception => exc
        puts '>>>>>>>>>>>>>>>>>>>>>>>ERROR<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
        puts exc.message
        puts '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
        "/assets/missing_img.jpg"
      end
  end

  # def getProcessedAvatar
  # 	if self.cover_image_uid
	 #    	image = self.cover_image
	 #    	image.process(:greyscale).url
	 #  end
  # end





  def get_bg_full
    if !self.bgimg.blank?
        self.bgimg_url(:full)
    end
  end

  def get_bg_thumb
    if !self.bgimg.blank?
        self.bgimg_url(:thumb)
    end
  end



  def psi_image_med
    # create background image with frame for fb posting
    if !self.bgimg.blank?
        self.bgimg_url(:psi_bg_framed)
    end
  end



  def psi_bg_380
    if !self.bgimg.blank?
        self.bgimg_url(:med)
    else
      "/assets/missing_img_small.jpg"
    end
  end


  def is_profile_incomplete?
  	if self.bg_image_uid.blank? || self.sport.blank?
      return true
    else
      return false
    end
  end

  def is_friend?(friend_id)
  	!!friendships.find_by_friend_id(friend_id)
  end

  def following?(followed)
  	!!followships.find_by_followed_id(followed)
  end

  def follow!(followed)
  	followships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
  	f = followships.find_by_followed_id(followed)
  	f.destroy if !f.nil?
  end

  def unfriend!(friend_id)
  	f = friendships.find_by_friend_id(friend_id)
  	f.destroy if !f.nil?
  end

  def add_wish!(prod_id)
    wishings.create!(:product_id => prod_id)
  end

  def rem_wish!(prod_id)
    w = wishings.find_by_product_id(prod_id)
    w.destroy if !w.nil?
  end

  def firstname
    @firstname ||= self[:firstname].capitalize if !self[:firstname].nil?
  end

  def lastname
    @lastname ||= self[:lastname].capitalize  if !self[:lastname].nil?
  end

  def is_active
    if self[:is_active].nil?
      @is_active ||=false
    else
      @is_active ||=self[:is_active]
    end
  end

  def favorite_teams
    if self[:favorite_teams].nil?
      @favorite_teams ||=[]
    else
      @favorite_teams ||=self[:favorite_teams]
    end
  end

  def favorite_athletes
    if self[:favorite_athletes].nil?
      @favorite_athletes ||=[]
    else
      @favorite_athletes ||=self[:favorite_athletes]
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end

  def facebook_friends
    facebook { |fb| fb.get_connection("me", "friends") }
  end

  def search_friends search_text
    match_result = []
    @fb_friends ||= facebook_friends
    if !@fb_friends.nil?
      @fb_friends.each do |friend|
        # puts friend
        if friend["name"] =~ /#{search_text}/i
          member = User.find_by_uid(friend["id"])
          if !member.nil?
              friend['member']=member['guid']
              friend['photo']=member.getAvatarSq_med
              friend['firstname'] = member.firstname
              friend['teammate'] = self.is_friend?(member.id)
              friend['active'] = member.is_active
            else
              friend['member']=false
              friend['photo'] = "https://graph.facebook.com/#{friend['id']}/picture?width=100&height=100"
              friend['firstname'] = friend['name'].split(" ").first
              friend['teammate'] = false
              friend['active'] = false
            end
          match_result << friend
        end
      end
    end
    return match_result
  end


  def cached_football_stats
   # self.football_stats.where(:is_active=>true).last
    Rails.cache.fetch([self, "football_stats"]) { football_stats.where(:is_active=>true).last }
  end

  def cached_soccer_stats
    #user.soccer_stats.where(:is_active=>true).last
    Rails.cache.fetch([self, "soccer_stats"]) { soccer_stats.where(:is_active=>true).last }
  end

  def cached_baseball_stats
    #user.baseball_stats.where(:is_active=>true).last
    Rails.cache.fetch([self, "baseball_stats"]) { baseball_stats.where(:is_active=>true).last }
  end


  def cached_basketball_stats
    #user.basketball_stats.where(:is_active=>true).last
    Rails.cache.fetch([self, "basketball_stats"]) { basketball_stats.where(:is_active=>true).last }
  end

  def setQRcode
     # puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
     # puts "#{ENV["WEBSITE_URL"]}qrcode.png"
     # puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
     self.remote_qrcode_url = "#{ENV["WEBSITE_URL"]}qrcode.png" if self.qrcode.blank?
     self.save!
  end



  private

    # def update_cover_related_thumbs
    #   self.avatar_tiny_uid = nil if self.cover_image_uid_changed?
    # end

    # def update_bg_related_thumbs
    #   if self.bg_image_uid_changed?
    #     self.bg_full_uid = nil
    #     self.psi_image_med_uid = nil
    #     self.psi_image_framed_uid = nil
    #   end

    # end

    def set_guid
    	if self.guid.nil?
    		# we have a create (to whom ever is reading this, I am sure I could use something like before_create instead, but I prefer this more controlled method)
      		self.guid = Digest::MD5.hexdigest("#{uid}--#{Time.now.to_i}")
  		end
    end



end
