Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "photos#index"
  resources :photos, only:[:index] do
    get 'page',:on => :collection
    get 'tags',:on => :collection
    post 'uploadpicture',:on => :collection
    post 'update_photo_tag',:on => :collection
    post 'drag_photo_tag',:on => :collection
  end
end
