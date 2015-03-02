Rails.application.routes.draw do


  root 'welcome#index'
  get 'welcome/index'
   
  post 'customer/new', to: 'customers#create'
  post 'customer/new_competition', to: 'customers#new_competition'
  resource :customer, except: :destroy do
	  member do
		  get 'login'
		  post 'login'
		  get 'greet'  # equivalent to member #index
		  get 'change_password'
		  get 'edit_competition'
		  get 'logout'
		  end
  end
  #resources :customers

  get 'competitions/display', to: 'display#choose_customer', as: :choose_display_customer
  get 'competitions/display/:customer_id', to: 'display#choose_competition', as: :choose_display_competition
  get 'competition/:competition_id/display', to: 'display#index', as: :luckydog
  get 'competition/:competition_id/display/grouping/:id(/:xyzzy)', to: 'display#grouping', as: :ryandog
  get 'competition/:competition_id/display/team/:id', to: 'display#team', as: :rustydog

  get 'competitions/:competition_id/results', to: 'results#index', as: :schmenge
  patch 'competitions/:competition_id/results/report', to: 'results#report', as: :report_score

  resource :competition do
	  get 'results', to: 'results#index'
	  patch 'results/report', to: 'results#report'
  end
	  
  resources :competitions do
	  resources :venues 
	  resources :validdates
	  resources :groupings do
		  resources :teams
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
  end

 
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
