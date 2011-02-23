Devotetest::Application.routes.draw do

  root :to => 'projects#index'

  resources :projects do

    member do
      put :update_test_suite
    end

    resource :test_suite

    resources :tests do
      resources :comments
    end

  end

end
