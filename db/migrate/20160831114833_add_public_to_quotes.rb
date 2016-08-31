class AddPublicToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :public, :boolean, index: true, default: false
  end
end
