class PhotosController < ApplicationController
	before_filter :authenticate_user!
  before_filter :checkFB_permissions

	def create
		@photos = []
		unless params[:photo_img].nil?
			params[:photo_img].each do |image|
        # puts image
				photo = current_user.photos.build(:photo_img => image)
				@photos << photo
				photo.save
			end
		end
    # respond_to do |format|
    #   format.js { render :content_type => 'text/plain', :layout => false}
    # end
	end

	def destroy
		unless  params["guid"].nil?
			p = Photo.find_by_guid(params["guid"])
			if p
				p.destroy
				@p_id = "gridphoto_#{p.guid}"
			end
		end
    # respond_to do |format|
    #   format.js { render :content_type => 'text/plain', :layout => false}
    # end
	end

	def show
		unless  params["guid"].nil?
			@photo = Photo.find_by_guid(params["guid"])
      @is_owner = false
      if @photo.user_id === current_user.id
        @is_owner = true
      end
		end
    # respond_to do |format|
    #   format.js { render :content_type => 'text/plain', :layout => false}
    # end
	end


  def show4crop
    unless  params["guid"].nil?
      @photo = Photo.find_by_guid(params["guid"])
      @is_owner = false
      if @photo.user_id === current_user.id
        @is_owner = true
      else
        @is_owner = false
        render json: {  :status => 'not owner of media' } and return
      end
    end
  end

  def save_desc
    photo_id = params["photo_id"]

    render json: {  :status => 'error' } and return  if photo_id.nil?
    @photo = Photo.find_by_guid(photo_id)
    render json: {  :status => 'error' } and return  if @photo.nil?
    if @photo.user_id === current_user.id
        @photo.description = params["photo_desc"].gsub /([^\n])\n([^\n])/, ' '
        @photo.save
    else
        render json: {  :status => 'not owner of media' } and return
    end

  end

  def share_on_fb
    begin
      photo_id = params["photo_id"]
      @error = false
      @error = true and return  if photo_id.nil?
      @photo = Photo.find_by_guid(photo_id)
      photo_desc = ''
      photo_desc = "#{@photo.description}.\n" if !@photo.description.blank?
      @error = true and return  if @photo.nil?
      if @photo.user_id === current_user.id
        @graph = Koala::Facebook::API.new(current_user.oauth_token)
        @graph.put_picture("#{ENV['WEBSITE_URI']}#{@photo.large1024}", {:message => "#{photo_desc}Check out my Personal Sports Identity on Youngvarsity:\n http://Youngvarsity.com/view/#{current_user.guid}"})
      else
          @error = true
      end
    rescue => e
      logger.error e.message
      puts e.message
      @error = true
    end
  end

  def import_photos
    photo_images = params["photo_images"]
    unless  photo_images.nil? || photo_images.empty?
      photo_images.each do |photo_url|
        photo = current_user.photos.new()
        photo.remote_photo_img_url = photo_url
        photo.save
      end
    end
    render json: {  :status => 'ok' }
  end


  def import_from_facebook
    photo_images = params["remote_image_url_field"]
    @photo = current_user.photos.new()
    @photo.remote_photo_img_url = photo_images
    @photo.save

  end


  def import_googleplus
    response =  {  :status => 'invalid_url' }
    album_url = params["album_url"]
    if !album_url.nil? && album_url =~ /plus.google.com/i
      uri = Addressable::URI.parse(album_url)

      path = uri.path.split('/')

      userid = path[2] if path[1] = "photos"
      albumid = path[4] if path[3] = "albums"
      authkey = uri.query_values["authkey"]
      authkey = "Gv1sRg#{authkey}" if !authkey.nil? # this string needs to be added when album url is coming from Gplus

      if !userid.nil? && !albumid.nil?
        status = "empty"
        image_data = parse_googleplus_picasa_images userid, albumid, authkey
        status = 'ok' if ( !image_data.nil? && image_data[:image_entries].count > 0 )
        response =  { :status => status, :data => image_data}
      end
    end
    render json: response
  end

  def import_picasa
    response =  {  :status => 'invalid_url' }
    album_url = params["album_url"]
    if !album_url.nil? && album_url =~ /picasaweb.google.com/i
      uri = Addressable::URI.parse(album_url)

      path = uri.path.split('/')

      userid = path[1]
      albumid = path[2]
      authkey = uri.query_values["authkey"]

      if !userid.nil? && !albumid.nil?
        status = "empty"
        image_data = parse_googleplus_picasa_images userid, albumid, authkey, true
        status = 'ok' if ( !image_data.nil? && image_data[:image_entries].count > 0 )
        response =  { :status => status, :data => image_data}
      end
    end
    render json: response
  end

  def parse_googleplus_picasa_images (userid, albumid, authkey = nil, fromPicasa = nil)
    albumLabel = "albumid"
    albumLabel = "album" if fromPicasa
    if !authkey.nil?
      url = "https://picasaweb.google.com/data/feed/api/user/#{userid}/#{albumLabel}/#{albumid}?imgmax=1600&authkey=#{authkey}"
    else
      url = "https://picasaweb.google.com/data/feed/api/user/#{userid}/#{albumLabel}/#{albumid}?imgmax=1600"
    end

    content = open(url).read
    doc = Nokogiri::XML(content)
    author_name = doc.css("author name").text
    author_link = doc.css("author uri").text

    entries = doc.search('entry').map do |entry|
      {
          :file => entry.xpath('media:group/media:content')[0].attr('url'),
          :thumbnail => entry.xpath('media:group/media:thumbnail')[2].attr('url'),
          :id => entry.xpath('gphoto:id').inner_text
      }
    end
    return {
      :image_entries        => entries,
      :img_owner_link       => author_link,
      :img_owner            => author_name
    }
  end


  def crop_save_image_sample

    coords = params[:crop_data]
    current_user.crop_x = coords['x']
    current_user.crop_y = coords['y']
    current_user.crop_w = coords['w']
    current_user.crop_h = coords['h']
    current_user.crop_iw = coords['iw']
    current_user.crop_ih = coords['ih']

    @error = false
    @error = true if coords.nil?

    current_user.crop_bgimg
    current_user.save!

  end



  def crop_save_image

    coords = params[:crop_data][:coords]
    if !coords.nil?
      @photo = current_user.photos.find_by_guid(params[:crop_data][:guid])
      render :nothing => true and return if @photo.nil?

      @photo.crop_x = coords['x']
      @photo.crop_y = coords['y']
      @photo.crop_w = coords['w']
      @photo.crop_h = coords['h']
      @photo.crop_iw = coords['iw']
      @photo.crop_ih = coords['ih']

      @error = coords.nil? ? true : false

      @photo.crop_photo
      @photo.save!

    else
      render :nothing => true and return
    end


  end

end
