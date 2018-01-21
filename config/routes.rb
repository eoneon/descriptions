Rails.application.routes.draw do
  resources :item_types
  resources :editions
  resources :media
  resources :item_fields
  resources :item_values

  resources :item_types do
    collection do
      post :import
    end
  end

  resources :media do
    collection do
      post :import
    end
  end

  resources :item_fields do
    collection do
      post :import
    end
  end

  resources :item_values do
    collection do
      post :import
    end
  end

  root to: 'item_types#index'
end
