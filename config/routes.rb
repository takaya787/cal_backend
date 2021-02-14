Rails.application.routes.draw do
  namespace 'api' do

    #シンプルに全てのeventsをloginなしで確認する用
    get '/events/all', to:"events#all"
    #login認証用
    post '/login', to:"auth#login"
    get '/auto_login', to:"auth#auto_login"

    #resources一覧
    resources :users
    resources :events
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
