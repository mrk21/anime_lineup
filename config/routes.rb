AnimeLineup::Application.routes.draw do
  root :to => 'lineups#show'
  
  resources :channels, :only=>[:index, :show, :update] do
    resources :airtimes, :only=>[:index, :show, :update]
  end
  
  resources :animes, :only=>[:index, :show, :update] do
    resources :airtimes, :only=>[:index, :show, :update]
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
