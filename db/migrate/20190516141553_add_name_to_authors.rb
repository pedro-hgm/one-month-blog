class AddNameToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :name, :string
    add_index :authors, :name, unique: true
  end
end
