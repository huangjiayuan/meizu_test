Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "photos#index"
  resources :photos, only:[:index] do
    collection do
      get 'page'
      get 'tags'
      post 'uploadpicture'
      post 'update_photo_tag'
      post 'drag_photo_tag'
    end

  end
end
