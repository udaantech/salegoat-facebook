FacebookAuthExample::Application.routes.draw do
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'

    resources :sessions, only: [:create, :destroy]

    resource :home, only: [:default, :putImage]
    resources :home do
		collection do
		  get "dashboard"
		  get "facebookGroup"
		  get "create"
		  get "putCheckBox"
		  get "privacy"
		   get "myorder"
		  post "putImage"
	   end
	  end
	  
	   resources :orders do
		get :execute
		get :cancel
	  end

    root to: "home#default"
end
