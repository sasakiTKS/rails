class ListsController < ApplicationController
  def new
      @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list.id)
      flash[:notice] = "投稿が成功しました"
    else
      render :new
    end
  end

  def index
      @lists = List.all
  end

  def show
      @list = List.find(params[:id])
  end

  def edit
      @list = List.find(params[:id])
  end

  def update
      list = List.find(params[:id])
      list.update(list_params)
      redirect_to list_path(list.id)
  end

  def destroy
      list = List.find(params[:id])
      list.destroy
      redirect_to '/lists'
  end

 private

  def list_params
    params.require(:list).permit(:title, :body, :image)
  end

end

# 表題10
# 投稿機能を追加するために記述を追加する3
# form_withに記述したList.newをインスタンス変数を用いてnewアクションに定義をする
# 変数の先頭に@マークをつけて定義するインスタンス変数@listをList.newを格納します
# これによりコントローラーとViewでデータの受け渡しができます
# (List.newだとコントローラーとViewでデータの受け渡しができない)
# rubyだとインスタンス変数は@小文字で始まる
# def new
# end
# ↓
# def new
#     # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
#     @list = List.new
# end
# 追加が完了したら再びapp/views/lists/new.html.erbに移動する。

# 表題12
# 投稿機能を追加するために記述を追加する5
# 投稿フォームのあるページを表示するnewアクションとは別に、
# 投稿を保存するためのcreateアクションを作成していきます
# インスタンスとは、オブジェクト指向で出てくる概念のひとつで
# 設計図（クラス）を具現化した「実体」のこと
# (インスタンスの作成は入力した文字やデータを実体化する)
# # 以下を追加
#   def create
#     list = List.new(list_params)
#       →フォームに記述した文字やデータを受け取り、新規でそれを登録するために
#       受け取ったデータを元にしてインスタンスを作成する
#     list.save
#       →saveメソッドを使いインスタンスをデータベースに保存する
#     redirect_to '/top'
#       →画面遷移（リダイレクト）を行う
#       ［この場合は/topの画面に遷移〔せんい〕する]
#   end
# createアクション内の変数（list）に@がありません
# 今回はローカル変数を利用して、createアクションの処理を行います。
# @のついたインスタンス変数とローカル変数の違いについて、
# @のついているインスタンス変数はビューファイルへ受け渡すことができます。
# @のついてないローカル変数は、
# ビューファイルに受け渡しができません。アクション内でしか利用できません。
# 今回はビューファイルへの受け渡しが必要ではないためローカル変数を利用しています。
# インスタンス変数でも同様の処理はできますが、無駄に利用できる範囲が広い変数は、
# 今後沢山の変数を利用するようになった際、不具合が起きる原因になります。

# 次にストロングパラメータと呼ばれるカラムを限定することによって、
# マスアサインメント脆弱性(セキュリティの穴)を防ぐコードを設定します
# 先ほどlist = List.newの後に入力したメソッド(list_params)がその要素の一つです
# params
# formから送られてくるデータはparamsの中に入っています。
# require
# 送られてきたデータの中からモデル名(ここでは:list)を指定しデータを絞り込みます。
# permit
# requireで絞り込んだデータの中から保存を許可するカラムを指定します。
# 実際にストロングパラメータを設定していきます
#   ↓↓最後尾↓↓
#   private
#   ストロングパラメータ↓
#     def list_params
#       params.require(:list).permit(:title, :body)
#     end
#   end
# ストロングパラメータを設定したことでセキュリティの穴を防ぐことが出来ましたが
# いまだセキュリティの脆弱性があるためメソッドの呼び出しに制限をかけます
# privateより後に記載することで定義されたメソッドは、
# アクションとして認識されなくなり、URLと対応できなくなります。
# 最後にサーバーを起動して機能を確認します。
# サーバー確認後はモデル連携を再度変更するためapp/views/lists/new.html.erbに
# 移動します(本来必要ない記述をしに行く)

# 表題14
# 一覧画面を表示しよう1
# コントローラにindexアクションを追加する
#   def index
#   end
#   ↓
#   def index
#     @lists = List.all
#   end
# @listsはインスタンス変数です
# インスタンス変数は自由に名前を決めることができますが、
# 今回は複数のListレコードが取得できるので、複数形で@listsという変数名にしました
# List.allはテーブルに保存されたデータを全取得します。
# allはメソッドの一種で、
# そのモデルがやりとりしているデータベースのテーブルに保存されている、
# 全てのレコードをまとめて取得します。
# 今回の場合はListからallメソッドを呼び出しているので、
# listsテーブルに保存されている全てのデータを取得することができます。
# 取得したデータを@listsというインスタンス変数に代入します
# コントローラー側の準備ができたのでapp/views/lists/index.html.erbに移動する

# 表題19
# # 詳細画面を作ろう2
# showアクションを作成します。
# 今回はレコードを1件だけ取得なのでインスタンス変数名は単数形の「@list」にします
# URLの引数を受け取るためにfindメソッドを使用します。
# 表題18に記載したparamsを用いたfindメソッドの動きを確認します
#   ①findメソッドによりレコードが習得される
#   ②paramsに格納される
#   paramsは送られてきたパラメーターを入れる箱のようなメソッドです
#   パラメーター（情報）はコントローラーはそのままの形で受け取れません
#   なので箱に入れてから送ります params[:カラム名]で記述する
#   ③コントローラに送られる
#   /lists/1    => List.find(params[:id]) => idが1のレコードを取得
#   /lists/2    => List.find(params[:id]) => idが2のレコードを取得
# 全体の記述は以下の形になり
#   @list = List.find(params[:id])
#   findメソッドで1や2を習得、paramsのカラムである:idにそれが送られ
#   @listにも習得したレコードの値が代入される。
# showアクションの作成が終わった後はapp/views/lists/show.html.erbに移動する

# 表題24
# 詳細画面を作ろう7
# createアクションのredirect_toを変更します
# 投稿後の動きを、topへのリダイレクトではなく、
# show.html.erbへリダイレクトさせて、投稿内容がすぐに閲覧できるようにします
#   def create
#     redirect_to '/top'
#     ↓
#     redirect_to list_path(list.id)
#     # 詳細画面(show.html.erb)へリダイレクト
#   end
# 変更後はサーバーを起動してlists/newで投稿後にlists/値のページに
# リダイレクトするか確認します

# 表題25
# 編集機能を作ろう1
# editアクションに以下の記述を追加します
# 　def edit
#   end
#   ↓
#   def edit
#     @list = List.find(params[:id])
#   end
# 今回は投稿済みのデータを編集するので、保存されているデータが必要です。
# findメソッドを用いて、データを取得します。
# 追記後にapp/views/lists/edit.html.erbに移動します


# 表題28
# 編集機能に更新機能を追加する1
# updateアクション(更新機能)を作成し、データの更新後を詳細画面に表示するために
# showアクションにリダイレクトさせます。このため、新たなビューは作成しません。
# showアクションにリダイレクトするために、引数には必ずidが必要になります。
#   def update
#     list = List.find(params[:id])
#     ↑idを習得してどの詳細画面を表示するか決定する(show.editと同じ)
#     list.update(list_params)
#     ↑updateに必要なコード
#     redirect_to list_path(list.id)
#     ↑このあとルーティングを設定してフォームとアクションを紐づけする
#   end
# コントローラの記述が終わったらconfig/routes.rbへ移動する

# 表題34
# 画像投稿機能を作ろう3
# コントローラ側に投稿機能はすでにあるので、値を受け取る許可を追記します。
# ストロングパラメータ内にimageを追加し、imageのデータの取得を許可します。
# private
#   def list_params
#     params.require(:list).permit(:title, :body, :image←これを追加)
#   end
# end
# app/views/lists/index.html.erbへ移動します

# 表題38
# 削除機能を作ろう2
# 削除をするためのdestroyアクションを追加します
#   def destroy
#   end
# ビュー側で実装する「削除」ボタンをクリックすると、
# 削除リストのid付きでURLが送信されます。
# つまり送られてきた削除idを元にレコードが探され、そのレコードを削除します。
# さらに、destroyメソッドによって、テーブルからデータが削除されます。
# 今回はデータ削除の後に一覧画面に戻るようにリダイレクトします。
# '/lists'（indexアクション）を指定する。
#   def destroy
#   end
#   ↓
#   def destroy
#     list = List.find(params[:id])  # データ（レコード）を1件取得
#     list.destroy  # データ（レコード）を削除
#     redirect_to '/lists'  # 投稿一覧画面へリダイレクト
#   end
# list = List.find(params[:id])でレコード1件が取得され、
# list.destroyでレコードが削除されます。
# redirect_to '/lists'でリストの一覧画面へリダイレクトされます。
# app/views/lists/show.html.erbに移動します

# 表題45
# バリデーション設定をしよう2
# 返されたバリデーションの結果を、コントローラで検出できるようにしましょう。
# if式を用いて、対象のカラムにデータが入力されていればsaveメソッドでtrueが返されます。
# この場合、次に表示したいページにリダイレクトさせます。
# 対象のカラムにデータが入力されていなければ、saveメソッドでfalseが返されます。
# falseならば、新規投稿ページを再表示するように設定します。
#   def create
#       list = List.new(list_params)
#       list.save
#       redirect_to list_path(list.id)
#   end
#   ↓
#   def create
#     @list = List.new(list_params)
#         エラーメッセージなどをviewファイルに伝えなくてはいけなくなったので
#         ローカル変数listからインスタンス変数@listに変更します
#     if @list.save
#       redirect_to list_path(@list.id)
#           やはり別viewへのアクセスが必要なためローカル変数listからインスタンス変数@listに変更します
#     else
#       render :new
#           renderとはアクション名で、同じコントローラ内の別アクションのViewを表示できます
#     end
#   end
# 記述変更後はapp/views/new.html.erbへ移動します

# 表題47
# redirect_toとrenderの処理の違いについて1
# renderとredirect_toの違いについて学習していきます
# redirect_to
# 1. redirect_toがルーティングにURLを送る
# 2. ルーティングと送られてきたURLとHTTPメソッドを照らし合わせて、どのコントローラのどのアクションを実行するかを決める
# 3. アクションを実行する
# 4. ビューを表示する
# ブラウザにURLを打って画面を表示させる時と同じ処理をしています。
# 「ブラウザにURLを打ち込む代わりにredirect_toで画面が遷移できる」と考えましょう。
# render
# 1. renderで定義したビューファイルを表示する。
# renderは直接ビューファイルを表示します。画面の遷移はなく、表示されているHTMLが入れ替わるのみです。
# renderとredirect_toの大きな違いを一つあげるとすると、新たにアクションを実行するかしないかという点があります。
# renderはアクションを新たに実行しない、redirect_toはアクションを新たに実行する
# renderは同じページをリダイレクトする場合はrender :new(現在、newのviewが表示中)でいいが
# 別のページにリダイレクトする場合は
#   @lists = List.all (現在、newのviewが表示中、def creae →@list←ここを参照にしている = List.new(list_params))
#   render :index (render 'index' あるいは render :index と書いて使用する。)
# と記述してcreateアクションの変数を用いてindexのインスタンス変数を用意してあげる必要があります。
# 無駄な記述が多くなり、他ページの表示をさせるのにはrenderは不向きです。
# しかしエラーメッセージを扱うのは同ページにリダイレクトすることが多くなるので、renderは有効で記述も少なくできます。
# 基本的には、エラーメッセージを扱う際にはrender、それ以外はredirect_toを使うと覚えておくとよいです
# app/models/list.rbに移動します

# 表題55
# フラッシュメッセージを実装してみよう1
# フラッシュメッセージがある場合、ユーザーは「自分の操作が成功したのか、失敗したのか」を知ることができます。
# フラッシュメッセージの実装に必要なパーツは以下の通りです。 パーツと役割を理解しつつ、実際にSampleAppのファイルを編集して、フラッシュメッセージを実装していきましょう。
# controllerからviewにメッセージを渡すflashメソッド、"flash[:notice]"
# viewファイルに必要な情報を送るための、controllerファイルの記述
# フラッシュメッセージを表示させるための、viewファイルの記述
# コードは以下のようになります。
# def create
#     @list = List.new(list_params)
#     if @list.save
#       redirect_to list_path(@list.id)
#     else
#       render :new
#     end
# end
# ↓
# def create
#     # １. データを受け取り新規登録するためのインスタンス作成
#     list = List.new(list_params)
#     # 2. データをデータベースに保存するためのsaveメソッド実行
#     list.save
#     # 3. フラッシュメッセージを定義し、詳細画面へリダイレクト
#     # flash[:notice]は「データを保管する箱」として機能します。
#     flash[:notice] = "投稿が成功しました"
#     redirect_to list_path(list.id)
# end
# このflash[:notice]はifメソッドの代わりの機能として使えます
# app/views/lists/show.html.erbへ移動します