class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
    #モデル作成コマンド実行時は「List」と単数形で書いたので、テーブル名は「lists」と複数形の英小文字になります。

      t.timestamps
      t.string :title #stringとは文字列のこと
      t.string :body #t.データ型 :カラム名(カラムとは列のこと)
    end
  end
end

#表題2
#モデルを作成する
# 順序で言うと
# 1⃣$ rails g model モデル(頭文字大文字)で4つのファイルを作成
# 2⃣その一つのファイルのmigrationファイルにカラムを追加
#  [migrarationファイルはテーブルを追加、編集させるためのもの]
# 3⃣migrationファイルをデータベースに反映させるために
#  rails db:migrateでテーブルを作成して反映させる
# 4⃣db/schema.rbを開き
#   t.string "title"
#   t.string "body"
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   上記の4つがあるか確認する

# 表題3
# 上記の表題2完了後
# rails g controller homes topでコントローラを作成し
# homes_controller.rbがapp/controllersの中に作成されているのを
# 確認するためにapp/controllers/homes_controller.rbを開きます