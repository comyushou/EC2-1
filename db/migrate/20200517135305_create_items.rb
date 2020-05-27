class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true, null: false
      t.string :name, null: false
      t.string :price, null: false
      t.string :picture_id, null: false
      t.boolean :is_sale_status, default: true, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
