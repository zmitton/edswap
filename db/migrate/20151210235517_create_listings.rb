class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.uuid :temp_email, index: true
      t.integer :author
      t.string :type
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
