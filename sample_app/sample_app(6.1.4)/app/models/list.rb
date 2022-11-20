class List < ApplicationRecord
      has_one_attached :image

      validates :title, presence: true
      validates :body, presence: true
      validates :image, presence: true

end

# 表題32
# 画像投稿機能を作ろう1
# has_one_attached :imageを追加します
# これによりListモデルにtitleとbodyに加えて画像を扱うための
# imageカラムが追記されたかのように扱うことができます。
# app/views/lists/new.html.erbに移動します

# 表題44
# バリデーション設定をしよう1
# 現状だと何も入力しなくても送信ボタンをクリックすれば投稿ができてしまいます。
# 画像、タイトル、本文が「必須」入力になるように設定しましょう。
# このような入力チェックを、「バリデーション」と呼びます。
# バリデーションによりsaveやupdateをする際のデータが妥当かどうかの検証ができます
# バリデーションを設定するには、モデルのファイルに設定内容を記述します。
# 今回、投稿に対して「必須入力」の設定が必要なので、Listモデルに記述を追加します。
#   validates :title, presence: true
#   validates :body, presence: true
#   validates :image, presence: true
# validatesで対象とする項目を指定し、入力されたデータのpresence（存在）をチェックします。
# trueと記述すると、データが存在しなければならないという設定になります。
# app/controllers/lists_controller.rbへ移動します

# 表題48
# rails cを使ってみよう1
# 前提条件として、この後のハンズオンではshowample_appを用いてCRUDを行いますが
# rails cで画像を扱う場合は複雑になるため、Listモデルに設定してあるimageのバリデーションをコメントアウトし
# タイトルと本文のみで投稿できるように変更します。
#   # コメントアウトする
#   # validates :image, presence: true
# "rails c"とは、Rails専用のコンソールを起動するためのコマンドです。
# Railsの機能や環境を読み込んだ上で、ターミナル上でRubyのコードを実行することができます。
# "rails c"では、主に下記三つのことを行うことができます。
# 1.実装する前に実装を考えているメソッドの動きを確認する
# 2.テーブルにどんなデータが格納されているか確認する
# 3.createが正常に動作し、テーブルに値が格納されたか確かめる
# 「rails c」の起動をします、下のような表記(プロンプト)が出れば成功です。
# Running via Spring preloader in process ----(ここは数値)
# Loading development environment (Rails 6.1.4)
# 3.1.2 :001 >
# exitと入力して一度終了させます
#標準のconsoleのデバックツールであるirbをpryに変更します
#irbでは実行出来ないコマンドもpryでは実行出来たりなど、
#irbよりもpryの方が機能的に優れたものになってます。
#また、pry-byebugというgemを入れることで、デバックを行うことも出来たりします
# コメントアウトしたコードを元に戻します
#Gemfileに移動します