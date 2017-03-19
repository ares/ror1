Rails.application.routes.draw do
  devise_for :users
  resources :computers do
    collection do
      get 'new_import'
      post 'import'
    end
  end

  get 'welcome/hello'

  get 'welcome/version'

  root 'welcome#hello'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
