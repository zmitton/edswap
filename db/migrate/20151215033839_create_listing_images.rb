class CreateListingImages < ActiveRecord::Migration
  def change
    create_table :listing_images do |t|
      t.integer :listing_id
      t.string  :url

      t.timestamps
    end
  end
end
