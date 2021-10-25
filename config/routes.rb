Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope 'api' do
    resources :items, only: %i[index update] do
      collection do
        get :price
      end
    end
  end
end
