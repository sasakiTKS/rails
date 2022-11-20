Rails.application.routes.draw do
  get 'top' => 'homes#top'
  resources :lists
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

# 表題6
# このファイルとこのファイルの中にhomesの要素が作成されているか確認する
# 省略されているが以下の2つの記述は同じ意味です。
# get 'homes/top'　←この時点だとこのコードが記述されている
# get 'homes/top' => 'homes#top
# 現時点だとurlの末尾を/homes/topにしないとアクセスができないため
# get 'homes/top'
# ↓
# get '/top' => 'homes#top
# にします(#に変わっているのに注意)
# これにより、urlの末尾が/topでアクセスできます

# 表題7
# listコントローラを作成します
# rails g controller lists new index show editのコマンドを実行する
# rails g controller listsの後ろにアクション名をつけることで、
# このroutes.rb内にlists/アクション名のファイルが作成できます。
# アクション名には主に
# new	データの新規作成フォームを表示する
# create	データを追加（保存）する
# index	データの一覧を表示する
# show	データの内容（詳細）を表示する
# edit	データを更新するためのフォームを表示する
# update	データを更新する
# destroy	データを削除する
# などがあります。
# 作成した後はサーバにアクセスし、
# それぞれ作成したアクション名をurlの末尾につけて確認する

# 表題8
# 投稿機能を追加するために記述を追加する1
# get 'lists/new'の真下に
# post 'lists' => 'lists#create'を追加する
# 簡単に言うとPOSTは「このデータあげます」の
# そのあとnewの要素を記述するので
# app/views/lists/new.html.erbを開きます

# 表題16
# 一覧画面を表示しよう3
# indexのアクションの記述を変更してurlの/listsの表示されるデータを
# 先ほど設定したviewsのindexのインスタンス変数、@listsのデータに変更します
# get 'lists/index'
# ↓
# get 'lists' （←これはURL）=> 'lists#index'(←これはindexの@lists)
# 記述を変更した後は一度サーバーを起動する。
# ここまでの状態だとeachメソッド内のテキストがa [#<List id: 1, crea～～
# となってるので、この状態を確認したらapp/views/lists/index.html.erbへ移動する

# 表題18
# 詳細画面を作ろう1
# showアクションのルーティングが作成されているので変更を加えます。
# 投稿データをURLの/lists/:id内の:idで判別させるためにURLに:idを追加します
# :idを設定することで.../lists/1 .../lists/2 .../lists/3 のように
# 詳細画面ごとにデータを保存し表示させることができる（:idでないと複数保存できない）
# どの投稿データを表示するかを判別するために、投稿データのidもURLに含めます。
# idを用いて実際のURLが/lists/1の場合、params[:id] と記述すると、id=1を取り出せる
# get 'lists/show'
# ↓
# get 'lists/:id' => 'lists#show'
# 変更後はapp/controllers/lists_controller.rbに移動する

# 表題22
# 詳細画面を作ろう5
# 名前付きルートの設定します。
# 名前付きルートとは、文字通りルーティング自体に名前をつけておくことです
# その名前をredirect_toやlink_toでも使用することができます。
# as:オプションを追加することで設定ができます。
# ここでは、「'lists#show'の設定を、listとして利用できる」の意味になります
# get 'lists/:id' => 'lists#show'
# ↓
# get 'lists/:id' => 'lists#show', as: 'list'
# 変更後はapp/views/lists/index.html.erbに移動します。

# 表題27
# 編集機能を作ろう3
# editアクションへのルーティングを変更します
# get 'lists/edit'
# ↓
# get 'lists/:id/edit' => 'lists#edit', as: 'edit_list'
# lists/:id/editのように、ルーティングのURLに:idを用いて記述すると、
# lists/◯◯/editのすべてのURLが対象になります。
# 今回も、名前付きルート（as: 'edit_list'）の記述を定義します
# サーバを起動して、https://...amazonaws.com/lists/1/editにアクセスします。
# タイトルと本文の箱内にデータが入っているか確認します
# 確認完了後はapp/controllers/lists_controller.rbへ移動します

# 表題29
# 編集機能に更新機能を追加する2
# 先ほどコントローラで指定したredirect_to list_path(list.id) に対して
#   patch 'lists/:id' => 'lists#update', as: 'update_list'
# を追加してフォームとアクションを紐つけていきます
# 更新の場合はPATCHで指定します。
# 追加後はapp/views/lists/edit.html.erbへ移動します

# 表題37
# 削除機能を作ろう1
# 余談だが2022年10月16日現在、ver7.0.4のrailsだとlink_toの削除機能が機能しない
# コントローラに実装するdestroyアクション用に、ルーティングを追加します
# HTTPメソッドはDELETE、URLはlists/:idです。
# 名前付きパスは、destroy_listと設定します。
# delete 'lists/:id' => 'lists#destroy', as: 'destroy_list'
# app/controllers/lists_controller.rbに移動します

# 表題41
# CRUD処理を学ぶ2
# 現時点のルーティングの記述だと、読みにくいし記述ミスもしやすいです
# 実はもっとルーティングの記述を短縮できる書き方のresourcesがあります。
# resourcesメソッドは、ルーティングを一括して自動生成してくれる機能です。
# Rails.application.routes.draw do
#   get 'lists/new'
#   get 'top' => 'homes#top'
#   post 'lists' => 'lists#create'
#   get 'lists' => 'lists#index'
#   get 'lists/:id' => 'lists#show', as: 'list'
#   get 'lists/:id/edit' => 'lists#edit', as: 'edit_list'
#   patch 'lists/:id' => 'lists#update', as: 'update_list'
#   delete 'lists/:id' => 'lists#destroy', as: 'destroy_list'
# end
# ↓
# Rails.application.routes.draw do
#   get 'top' => 'homes#top'
#   resources :list
# end
# 上記のように記述したlistの要素をすべて削除してresources :listを記述します
# resources :listは以下のルーティングを自動生成してくれます
# (括弧の中身は、主に使われることの多い機能です。)
# new(投稿を作成する画面)
# show(投稿の詳細画面)
# index(投稿の一覧画面)
# edit(投稿の編集画面)
# create(投稿作成)
# destroy(投稿削除)
# update(投稿更新)
# 記述を変更後rails routesで確認すると
# ーーーーーーーーーー変更前ーーーーーーーーーー
#                         Prefix Verb   URI Pattern                                                                                       Controller#Action
#                       lists_new GET    /lists/new(.:format)                                                                              lists#new
#                           lists POST   /lists(.:format)                                                                                  lists#create
#                                 GET    /lists(.:format)                                                                                  lists#index
#                           list GET    /lists/:id(.:format)                                                                              lists#show
#                       edit_list GET    /lists/:id/edit(.:format)                                                                         lists#edit
#                             top GET    /top(.:format)                                                                                    homes#top
#                     update_list PATCH  /lists/:id(.:format)                                                                              lists#update
#                   destroy_list DELETE /lists/:id(.:format)                                                                              lists#destroy
#             rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#       rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                 GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#       rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
# rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                 GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#             rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#       update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#           rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

# ーーーーーーーーーー変更後ーーーーーーーーーー
#                         Prefix Verb   URI Pattern                                                                                       Controller#Action
#                             top GET    /top(.:format)                                                                                    homes#top
#                           lists GET    /lists(.:format)                                                                                  lists#index
#                                 POST   /lists(.:format)                                                                                  lists#create
#                       new_list GET    /lists/new(.:format)                                                                              lists#new
#                       edit_list GET    /lists/:id/edit(.:format)                                                                         lists#edit
#                           list GET    /lists/:id(.:format)                                                                              lists#show
#                                 PATCH  /lists/:id(.:format)                                                                              lists#update
#                                 PUT    /lists/:id(.:format)                                                                              lists#update
#                                 DELETE /lists/:id(.:format)                                                                              lists#destroy
#             rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#       rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                 GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#       rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
# rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                 GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#             rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#       update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#           rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
# となっており、ルーティングをほとんど形成されている。
# しかし以下のコードのようにルーティングで設定した名前付きルートがなくなっているので
# destroy_list DELETE /lists/:id(.:format)  lists#destroy
# ↓
# DELETE /lists/:id(.:format)  lists#destroy
# 名前付きルートを使用しているviewファイルの記述を変更する必要がある。
# app/views/lists/show.html.erbへ移動する。