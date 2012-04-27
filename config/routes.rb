WorldWeather::Application.routes.draw do

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  get "home/index"

  root :to => "home#index"

  match '/creatary/(:string)' => Creatary::API , :as => :creatary

  match '/authorize' => 'home#authorize'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

end
