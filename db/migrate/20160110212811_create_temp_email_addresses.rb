class CreateTempEmailAddresses < ActiveRecord::Migration
  def change
    create_table :temp_email_addresses do |t|
      t.integer  :listing_id, index: true
      t.string   :real_email_address
      t.uuid     :temp_email_address, index: true

      t.timestamps
    end
  end
end
