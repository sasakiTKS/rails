Rails.application.routes.draw do
   root :to => 'homes#top'
 # root "books#index"
   resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# rootメソッドを使うことでルートへアクセスした場合に特定のアクションを呼び出すことが可能
