class List < ApplicationRecord
      has_one_attached :image
end

# 表題32
# 画像投稿機能を作ろう1
# has_one_attached :imageを追加します
# これによりListモデルにtitleとbodyに加えて画像を扱うための
# imageカラムが追記されたかのように扱うことができます。
# app/views/lists/new.html.erbに移動します