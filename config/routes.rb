Lookatmepuma::Application.routes.draw do

    devise_for :users #, :controllers => { :registrations => 'registrations' }

    namespace :admin do
      root :to => 'disciplines#index'

      resources :disciplines, :only => [:index, :show, :destroy] do
        resources :votes, :only => [:index, :destroy]
        resources :photos, :only => [:create, :destroy]
        member do
          get :approve
          get :reject
        end
        collection do
          get :winners
          get :send_notification_to_winners
        end
      end

      resources :settings, :only => [:index] do
        get :start
        get :stop
      end
    end

    resources :purchases
    resources :disciplines, :only => [:index] do
      member do
        get :like
        get :confirm
        get :show
      end
    end
    resources :votes do
      member do
        get :confirm
      end
    end

    match 'confirmations/confirm', :to => 'confirmations#confirm', :as => :confirmations

    root :to => 'hello#index'

end
