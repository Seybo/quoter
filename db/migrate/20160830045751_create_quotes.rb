class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|

      t.timestamps null: false
      t.text "text", null: false
      t.string "author", null: false
      t.belongs_to :user, index: true, foreign_key: true
      
    end
  end
end
