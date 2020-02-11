Rails.application.routes.draw do

  get '/' => "home#top"

  # 記録ここから
  get 'records' => 'training_record#index'
  post 'training_record/create' => 'training_record#create'
  get 'training_record/edit'
  get '/records/event/:name' => 'training_record#event'
  get '/records/:id' => 'training_record#show'
  get '/records/:id/events/' => 'training_record#eventindex'
  get '/records/:id/edit' => 'training_record#edit'
  patch '/records/:id/update' => 'training_record#update'
  delete '/records/:id' => 'training_record#destroy'
  get 'sessions/new'

  # 種目名登録ここから
  post 'menu_register/create' => 'training_record#register'

  # ユーザーここから
  get '/users/new' => 'users#new'
  post 'users/create' => 'users#create'
  get '/users/:id' => 'users#show'
  patch '/users/update/:id' => 'users#update'
  get '/users/:id/events/:name' => 'users#event'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post '/test_login' => 'sessions#test_login'
  delete 'logout' => 'sessions#destroy'

  #API
  namespace :api, format: 'json' do
    resources :training_record
    get 'weight' => 'training_record#weight'
    get '/users/:id/events/:name' => 'training_record#usersweight'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

