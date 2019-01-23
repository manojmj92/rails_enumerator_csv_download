Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :exports, only: [:index] do
    collection do
      get :stream_csv
      get :normal_csv
    end
  end
end
