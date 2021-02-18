Rails.application.routes.draw do

  namespace 'api' do

    #シンプルに全てのeventsをloginなしで確認する用
    get '/events/all', to:"events#all"

    #シンプルに全てのtasksをloginなしで確認する用
    get '/tasks/all', to:"tasks#all"
    #taskのcompletedを変更するための関数
    get '/tasks/change/:id', to:"tasks#change"

    #login認証用
    post '/login', to:"auth#login"
    get '/auto_login', to:"auth#auto_login"

    #resources一覧
    resources :tasks
    resources :users
    resources :events
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
