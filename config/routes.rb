AnimeLineup::Application.routes.draw do
  root :to => 'lineups#show'
  
  resources :channels, :only=>[:index, :show, :create, :update, :destroy]
  resources :animes, :only=>[:index, :show, :create, :update, :destroy] do
    member do
      get :image
      get :thumbnail
      get :video
      get :site
      get :suggested_image_urls
      get :suggested_video_urls
      get :suggested_site_urls
    end
  end
  
  resources :lineups, :only=>:show
  resource :lineup, :only=>:show, :path=>:today_lineup, :as=>:today_lineup
  
  resource :system_setting, :only=>[:show, :update]
end
