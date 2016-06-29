class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :inventory
      t.decimal :price, precision: 5, scale: 2
      t.references :category, index: true
    end
  end
end
