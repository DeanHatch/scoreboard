Rails.application.routes.draw do

  devise_for :customers, controllers: {sessions: 'customers/sessions'}
  devise_scope :customer do
    get "customer/sign_out", to: "customers/sessions#destroy", as: "customer_sign_out"
  end
  resource :customer, only: [:show, :edit, :update] do
    get 'list_competitions'
    get 'new_competition'
    post 'create_competition'
    get 'edit_competition/:competition_id', to: 'customers#edit_competition', as: :edit_competition
    patch 'update_competition'
    put 'update_competition'
    get 'set_competition_passwords'
  end 
  
  resources :valid_times

  root 'welcome#index'
  get 'welcome/index'
  get 'oops', to: 'welcome#oops'
  get 'what_we_do', to: 'welcome#what_we_do'
  get 'whats_new', to: 'welcome#whats_new'
  get 'contact_us', to: 'welcome#contact_us'
  get 'send_us_a_message', to: 'welcome#send_us_a_message'
  get 'thanks_for_the_message', to: 'welcome#thanks_for_the_message'
  get 'pricing', to: 'welcome#pricing'
  get 'for_org', to: 'welcome#for_org'
  get 'for_fans', to: 'welcome#for_fans'
  get 'demos', to: 'welcome#demos'
  
  get 'display', to: 'welcome#index'
  get 'display/:competition_id', to: 'display#index', as: :display_competition
  get 'display/:competition_id/grouping/:id(/:xyzzy)', to: 'display#grouping', as: :display_grouping
  get 'display/:competition_id/team/:id', to: 'display#team', as: :display_team
  get 'display/:competition_id/team/:id/alert', to: 'display#alert_request', as: :alert_request
  post 'display/:competition_id/team/:id/alert', to: 'display#set_alert', as: :set_alert
   
  get 'get_competition_link_recipient/:competition_id',
	        to: 'share_links#get_competition_link_recipient',
		as: :get_competition_link_recipient
  patch 'send_competition_link',
		to: 'share_links#send_competition_link',
		as: :send_competition_link
			 
  get "manager_session/login/:manager_id", to: "manager_sessions#new", as: :login_manager_session
  resource :manager_session, only: [:create]  do
		    # Since an HTTP DELETE request via a #link_to method is
		    # somewhat dicey, and since the DELETE would only be 
		    # deleting a session we handle this with an HTTP GET
	   get 'logout' # , as: :logout_manager_session
  end
  resource :manager, except: [:create, :destroy ] do
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
  resources :validdates, only: [:create] 
  resources :groupings, :shallow => true do
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
  
  
  resources :bracketgroupings, only: [:index, :show] do
	get 'complete', on: :member
	post 'complete', on: :member
	post 'complete_create', on: :member
	  # httpverb /competitions/:competition_id/brackets/...
	  resources :bracketcontests, only: [:show, :new, :edit, :create, :update, :destroy]  do
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
  end # of bracketgroupings resource


  
  get "scorer_session/login/:scorer_id", to: "scorer_sessions#new", as: :login_scorer_session
  resource :scorer_session, only: [:create]  do
	  member do
		    # Since an HTTP DELETE request via a #link_to method is
		    # somewhat dicey, and since the DELETE would only be 
		    # deleting a session we handle this with an HTTP GET
		  get 'logout'
		  end
  end
  get 'scorer/index',  to: 'scorers#index'
  patch 'scorer/report',  to: 'scorers#report'
 
 
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
