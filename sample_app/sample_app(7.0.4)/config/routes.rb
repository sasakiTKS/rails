Rails.application.routes.draw do
  get 'lists/new'
  post 'lists' => 'lists#create'
  get 'lists' => 'lists#index'
  get 'lists/:id' => 'lists#show', as: 'list'
  get 'lists/:id/edit' => 'lists#edit', as: 'edit_list'
  get '/top' => 'homes#top'
  patch 'lists/:id' => 'lists#update', as: 'update_list'
  delete 'lists/:id' => 'lists#destroy', as: 'destroy_list'
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
# コントローラに実装するdestroyアクション用に、ルーティングを追加します
# HTTPメソッドはDELETE、URLはlists/:idです。
# 名前付きパスは、destroy_listと設定します。
# delete 'lists/:id' => 'lists#destroy', as: 'destroy_list'
# app/controllers/lists_controller.rbに移動します