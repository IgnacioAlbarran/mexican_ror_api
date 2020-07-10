class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :website
      t.string :phone_number
      t.decimal :lat
      t.decimal :lng
      t.integer :category_id_a
      t.integer :category_id_b
      t.boolean :closed
      t.string :hours

      t.timestamps
    end
  end
end
