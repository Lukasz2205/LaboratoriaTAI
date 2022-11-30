class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :pages, null: false
      t.string :author, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
