Rails.application.routes.draw do


  root 'welcome#index'
  get 'welcome/index'
  
  get 'display', to: 'display#choose_customer', as: :choose_display_customer
  get 'display/customer/:customer_id', to: 'display#choose_competition', as: :choose_display_competition
  get 'display/:competition_id', to: 'display#index', as: :display_competition
  get 'display/:competition_id/grouping/:id(/:xyzzy)', to: 'display#grouping', as: :display_grouping
  get 'display/:competition_id/team/:id', to: 'display#team', as: :display_team
   
  post 'customer/new', to: 'customers#create'
  post 'customer/new_competition', to: 'customers#new_competition'
  resource :customer, except: :destroy do
	  member do
		  get 'greet'  # equivalent to member #index
		  get 'change_password'
		  patch 'update_password'
		  get 'edit_competition'
		  get 'set_competition_passwords'
		  end
  end
  
  resource :customer_session, only: [:new, :create]  do
	  member do
		    # Since an HTTP DELETE request via a #link_to method is
		    # somewhat dicey, and since the DELETE would only be 
		    # deleting a session we handle this with an HTTP GET
		  get 'logout' # , as: :logout_customer_session
		  end
  end
  
  get "manager_session/login/:manager_id", to: "manager_sessions#new", as: :login_manager_session
  resource :manager_session, only: [:create]  do
		    # Since an HTTP DELETE request via a #link_to method is
		    # somewhat dicey, and since the DELETE would only be 
		    # deleting a session we handle this with an HTTP GET
	   get 'logout' # , as: :logout_manager_session
  end
  resource :manager, except: [:create, :destroy ] do
	  get 'choose_customer',
		on: :collection
	  get 'choose_competition_for/:customer_id',
		to: 'managers#choose_competition',
		on: :member,
		as: :choose_competition
	  member do
		  get 'greet'  # equivalent to member #index
		  get 'passwords'  # displays prompt page for passwords
		  patch 'change_manager_password'
		  patch 'clear_manager_password'
		  patch 'change_scorer_password'
		  patch 'clear_scorer_password'
	  end
  end
  
	  
  resources :venues 
  resources :validdates
  resources :groupings do
	  resources :teams
  end
  
  resources :regularcontests do
	  # get /competitions/:competition_id/regularcontests/dump
	  get 'dump', on: :collection
	  # This provides get /competitions/:competition_id/regularcontests/rrobin
	  # with rrobin_competition_regularcontests_path()
	  get 'rrobin', on: :collection
	  # This provides post /competitions/:competition_id/regularcontests/roundrobin
	  # with roundrobin_competition_regularcontests_path()
	  post 'roundrobin', on: :collection
  end
  
  
  resources :brackets, only: [:index, :show] do
	  # httpverb /competitions/:competition_id/brackets/...
	  resources :bracketcontests do
		  # get /competitions/:competition_id/bracket/:bracket_id/bracketcontests/dump
		  get 'dump', on: :collection
		  # get /competitions/:competition_id/bracket/:bracket_id/bracketcontests/edithome
		  get 'edithome', on: :member
		  # patch/put /competitions/:competition_id/bracket/:bracket_id/bracketcontests/updthome
		  patch 'updthome', on: :member
		  put 'updthome', on: :member
		  # get /competitions/:competition_id/bracket/:bracket_id/bracketcontests/editaway
		  get 'editaway', on: :member
		  # patch/put /competitions/:competition_id/bracket/:bracket_id/bracketcontests/updtaway
		  patch 'updtaway', on: :member
		  put 'updtaway', on: :member
	  end # of bracketcontests resource
  end # of brackets resource


  get 'competitions/results', to: 'results#choose_customer', as: :choose_results_customer
  get 'competitions/results/:customer_id', to: 'results#choose_competition', as: :choose_results_competition
  get 'competitions/:competition_id/results', to: 'results#index', as: :competition_results
  patch 'competitions/:competition_id/results/report', to: 'results#report', as: :report_score


 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
