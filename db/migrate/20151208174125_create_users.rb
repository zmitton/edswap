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

      t.boolean :teacher

      t.timestamps null: false
    end
  end
end
