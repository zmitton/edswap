class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :oauth_email
      t.string :preferred_email
      t.string :password_digest
      t.datetime :oauth_expires_at

      t.string :phone_number

      t.uuid    :password_reset_code
      t.datetime :password_reset_code_expires_at

      t.string :image_path
      
      t.boolean :teacher
      t.boolean :parent
      t.boolean :community_member

      t.timestamps null: false
    end
  end
end
