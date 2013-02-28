class AddOauthTokenAndOauthExpiresAt < ActiveRecord::Migration

    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime

end
