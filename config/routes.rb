Devotetest::Application.routes.draw do
  root :to => 'projects#index'

  resources :projects do

    member do
      put :update_test_suite
    end

    resource :test_suite do
      resources :test do
        resources :comments
      end
    end
  end
  
  resources :test_suites do
    
  end
end
