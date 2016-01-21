class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :author_id
      t.string :subject
      t.text :body
      t.boolean :active

      t.boolean :buying
      t.boolean :selling
      t.boolean :lending
      t.boolean :trading
      t.boolean :borrowing

      t.timestamps null: false
    end
  end
end
