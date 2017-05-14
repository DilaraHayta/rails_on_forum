RailsOnForum::Application.routes.draw do
  get    '/oturum_ac',     to: 'sessions#new',     as: :login
  delete '/oturumu_kapat', to: 'sessions#destroy', as: :logout
  resource  :session, only: :create

  get    '/com_oturum_ac',     to: 'company_sessions#new',     as: :com_login
  delete '/com_oturumu_kapat', to: 'company_sessions#destroy', as: :com_logout
  resource  :company_session, only: :create

  resources :forums, only: [:index, :show], path: 'forumlar' do
    resources :topics, only: [:new, :create],
                       path: 'konular',
                       path_names: {new: 'yeni'}
  end

  resources :topics, except: [:index, :new, :create],
                     path: 'konular', path_names: {edit: 'duzenle'} do
    resources :comments, only: [:new, :create],
                         path: 'yorumlar',
                         path_names: {new: 'yeni'}
  end

  resources :comments, only: [:edit, :update, :destroy],
                       path: 'yorumlar',
                       path_names: {edit: 'duzenle'}

  resources :users,   only: [:create, :update, :destroy]
    get '/kaydol',      to: 'users#new',  as: :register
    get '/:id',         to: 'users#show', as: :profile
    get '/:id/duzenle', to: 'users#edit', as: :edit_profile


  resources :companies
    get '/com_kaydol',      to: 'companies#new',  as: :com_register
    get '/:id',         to: 'companies#show', as: :com_profile
    get '/:id/duzenle', to: 'companies#edit', as: :com_edit_profile

  root 'forums#index'
end
