Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :photos, only:[:index] do
    get 'page',:on => :collection
    post 'uploadpicture',:on => :collection
  end
end
