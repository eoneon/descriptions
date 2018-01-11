Rails.application.routes.draw do
  resources :item_types
  resources :media

  resources :media do
    collection do
      post :import
    end
  end
  
  root to: 'item_types#index'
end
