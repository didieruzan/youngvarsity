Yv::Application.routes.draw do

  get "announcement/hide"

  get "cpadmin/index"

  resources :products,  :has_many => [:prodimages]

  resources :prodimages, :collectibles

  devise_for :users,  path_names:   { sign_in: 'login', sign_out: 'logout' },
                      controllers:  { omniauth_callbacks: 'omniauth_callbacks' }

  resources :friendships
  resources :followships, :only => [:create, :destroy]


  resources :users, :has_many => [:photos, :comments]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :photos, :has_many => [:comments, :users]

  resources :comments, :inmessages, :cpadmin, :picasa, :categories, :invitations, :football_stats,
            :basketball_stats, :baseball_stats, :soccer_stats


  match 'import_from_facebook'    => "photos#import_from_facebook"

  match 'show4crop'               =>  "photos#show4crop"

  match 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  match "test"                    => "welcome#test"

  match "app"                     => "welcome#app"

  match "promo_baseball"          => "welcome#likegate_baseball"
  match "promo_football"          => "welcome#likegate_football"

  match "welcome"                 =>  'welcome#index'
  match "terms"                   =>  'welcome#terms'
  match "privacy"                 =>  'welcome#privacy'

  match 'me/:nickname'            => "users#public_profile"
  match "me"                      =>  "users#me" #"users#index"
  match "media"                   =>  "users#media"
  match "profile"                 =>  "users#edit"
  match "profile_ref"             =>  "users#refreshed_edit"
  match "search_user"             =>  "users#search"
  match "contact-us"              =>  "inmessages#new"

  match "team"                    =>  "users#team"
  match "share"                   =>  "users#share"
  get   "/psi_img_m/:guid"        =>  "users#psi_img_med"
  post "/crop_psi"                =>  "users#crop_psi_bg"

  match "/photo/show/:id"         => "photos#show"
  match "/photo/delete/:guid"     => "photos#destroy"

  match "/comment/delete/:guid"   => "comments#destroy"

  post "/import_googleplus"       => "photos#import_googleplus"
  post "/import_picasa"           => "photos#import_picasa"
  post "/import_selected_photos"  => "photos#import_photos"
  post "/crop_save_image"         => "photos#crop_save_image"
  post "/photo_save_desc"         => "photos#save_desc"
  post "/photo_share_on_fb"       => "photos#share_on_fb"

  match "stats"                   => "users#stats"

  match "controls"           => "users#control_panel"

  match "/prodimage/delete/:ppid" => "prodimages#destroy"
  get "/view/:id"                 => "users#public_profile"
  match "/channel.html"           => "page#fbchannel"

  match "/teammates"              => "friendships#list"

  post "/crop_cardimage"          =>  "collectibles#crop_photo"
  post "/get_stat_table"           =>  "collectibles#get_stat_table"
  match "/order_print/:id"               =>  "collectibles#order_print", :as => :print_collectible

  match "/cancel_print/:id"        =>  "collectibles#cancel_print", :as => :cancel_print_collectible

  get "/unfriend/:fid"            => "friendships#unfriend"
  get "/teammate/:fid"            => "friendships#create"

  get "/friendfb/:fb_id"          => "friendships#friend_by_facebook_id"

  post "/save_invite_request"     => "welcome#save_invite_request"
  post "/users/:id"               => "users#update"
  get "/invite/:fb_id"            => "users#invite"

  match "lead"                    =>  "leads#index"
  post "/check_lead"              =>  "leads#check_lead"
  post "/save_lead"               => "leads#save_lead"


  match "prodsgrid"               => "products#gridview"

  match "itemview"               => "products#itemview"

  match "wishlist(/:guid)"  => "products#wishlist"

  post "/add_wish"        => "wishes#create"
  post "/rem_wish"        => "wishes#destroy"

  get "post_psi_on_fb"    => "users#post_psi_on_fb"


  match "qrcode"        => "users#qrcode"

  match "qrcode_sm"        => "users#qrcode_sm"

  match "test_exception_notifier" => "application#test_exception_notifier"

  root :to => 'welcome#index'

end
