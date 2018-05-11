# == Schema Information
#
# Table name: mvp_surveys
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  age                    :string(255)
#  sports_list            :string(255)
#  photo_taker            :string(255)
#  photo_storage_location :string(255)
#  share_photos_with      :string(255)
#  like_zoom_crop_photos  :string(255)
#  like_share_psi_cover   :string(255)
#  like_season_album      :string(255)
#  maintain_stats         :string(255)
#  compare_stats          :string(255)
#  like_compare_stats_pro :string(255)
#  visit_team_website     :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class MvpSurvey < ActiveRecord::Base
  belongs_to :user

  attr_accessible :age, :sports_list, :photo_taker, :photo_storage_location, :share_photos_with, :like_zoom_crop_photos,
                  :like_share_psi_cover, :like_season_album, :maintain_stats, :compare_stats, :like_compare_stats_pro,
                  :visit_team_website

end
