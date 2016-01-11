class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :locationeable_type
      t.integer :locationeable_id
      t.string :school_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :x_coord
      t.string :y_coord
    end
  end
end
