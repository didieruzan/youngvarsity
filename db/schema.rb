# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130807154234) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "baseball_stats", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.integer  "games_played"
    t.integer  "batting_average"
    t.integer  "on_base_percentage"
    t.integer  "run_batted_in"
    t.integer  "hits"
    t.integer  "runs"
    t.integer  "plate_appearances"
    t.integer  "at_bat"
    t.integer  "home_runs"
    t.integer  "putout"
    t.integer  "assists"
    t.integer  "fielding_errors"
    t.integer  "total_chances"
    t.integer  "fielding_percentage"
    t.integer  "stolen_bases"
    t.integer  "caught_stealing"
    t.integer  "earned_run_average"
    t.integer  "win"
    t.integer  "loss"
    t.integer  "hits_against"
    t.integer  "runs_against"
    t.integer  "earned_runs"
    t.integer  "inning_pitched"
    t.integer  "pitching_save"
    t.integer  "strikeout"
  end

  create_table "basketball_stats", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.integer  "games_played"
    t.integer  "point_game"
    t.integer  "assist_game"
    t.integer  "rebounds_game"
    t.integer  "field_goal"
    t.integer  "three_pt_percentage"
    t.integer  "ft_percentage"
    t.integer  "steals_game"
    t.integer  "blocks_game"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "categorizations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "collectibles", :force => true do |t|
    t.string   "srcphoto"
    t.integer  "user_id"
    t.string   "field_pos"
    t.string   "team_name"
    t.integer  "jersey_num"
    t.string   "photo_front"
    t.string   "photo_back"
    t.string   "style"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "orientation"
    t.string   "latest_stats"
    t.text     "shipping_address"
    t.string   "phone"
    t.boolean  "to_print"
  end

  create_table "comments", :force => true do |t|
    t.text     "post"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "guid"
  end

  add_index "comments", ["photo_id"], :name => "index_comments_on_photo_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "followships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followships", ["followed_id"], :name => "index_followships_on_followed_id"
  add_index "followships", ["follower_id", "followed_id"], :name => "index_followships_on_follower_id_and_followed_id", :unique => true
  add_index "followships", ["follower_id"], :name => "index_followships_on_follower_id"

  create_table "football_stats", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "number_of_games_played"
    t.integer  "pass_attempts"
    t.integer  "pass_completions"
    t.integer  "passing_yards"
    t.integer  "pass_touchdowns"
    t.integer  "pass_interceptions"
    t.integer  "passer_rating"
    t.integer  "attempts_carries"
    t.integer  "rush_yards"
    t.integer  "rush_yards_att"
    t.integer  "rush_longest"
    t.integer  "rush_td"
    t.integer  "received"
    t.integer  "receiv_yards"
    t.integer  "receiv_avg"
    t.integer  "receiv_long"
    t.integer  "receiv_touchdowns"
    t.integer  "kick_xpm"
    t.integer  "kick_xpa"
    t.integer  "kick_xpp"
    t.integer  "kick_fgm"
    t.integer  "kick_fga"
    t.integer  "kick_fgp"
    t.integer  "kick_longest"
    t.integer  "kick_op"
    t.integer  "defense_tackles_solo"
    t.integer  "defense_tackles_assist"
    t.integer  "defense_sacks"
    t.integer  "defense_fumbles"
    t.integer  "defense_interceptions"
    t.integer  "defense_yards"
    t.integer  "defense_longest"
    t.integer  "defense_td"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id", "user_id"], :name => "index_friendships_on_friend_id_and_user_id", :unique => true
  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "inmessages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invitations", :force => true do |t|
    t.string   "token"
    t.boolean  "is_active",  :default => true
    t.integer  "date_used"
    t.integer  "sender"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "recipient"
    t.string   "comments"
  end

  create_table "invitereqs", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leads", :force => true do |t|
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "photo_image_uid"
    t.string   "guid"
    t.string   "photo_img"
    t.string   "description"
  end

  create_table "prodimages", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "sku"
    t.string   "manufacturer"
    t.string   "title"
    t.text     "description_short"
    t.text     "description"
    t.decimal  "price",             :precision => 6, :scale => 2
    t.string   "url"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "is_active"
  end

  create_table "soccer_stats", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.integer  "games_played"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "shots"
    t.integer  "shot_avg"
    t.integer  "saves_on_goals"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "guid"
    t.string   "nickname"
    t.integer  "dob"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "gender"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "local"
    t.string   "email",                                               :null => false
    t.string   "facebook_id"
    t.string   "ipaddress"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "encrypted_password",     :default => "",              :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "cover_image_uid"
    t.string   "bg_image_uid"
    t.text     "bio"
    t.string   "sport"
    t.string   "team_name"
    t.string   "box_pos",                :default => "right"
    t.string   "box_text_col",           :default => "E2DFDD"
    t.string   "field_pos"
    t.string   "school_name"
    t.string   "box_bg_color"
    t.string   "theme"
    t.boolean  "is_admin"
    t.boolean  "is_active"
    t.string   "align_landscape",        :default => "top center"
    t.string   "align_portrait",         :default => "center center"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "is_invited"
    t.text     "favorite_athletes"
    t.text     "favorite_teams"
    t.string   "teamurl"
    t.string   "avatar_tiny_uid"
    t.string   "bg_full_uid"
    t.string   "psi_image_med_uid"
    t.string   "psi_image_framed_uid"
    t.string   "bgimg"
    t.string   "profileimg"
    t.string   "qrcode"
    t.integer  "jersey_num"
    t.string   "height"
    t.string   "weight"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishings", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
