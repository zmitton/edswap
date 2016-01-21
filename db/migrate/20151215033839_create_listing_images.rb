class CreateListingImages < ActiveRecord::Migration
  def change
    create_table :listing_images do |t|
      t.integer  :listing_id
      t.integer  :precedence 
      t.string   :image_path

      t.timestamps
    end
  end
end
