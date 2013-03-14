class AddFavoriteansweridColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :favorite_answer_id, :integers
  end
end
