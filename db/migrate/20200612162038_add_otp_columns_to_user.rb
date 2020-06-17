class AddOtpColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_secret, :string
    add_column :users, :last_otp_at, :datetime
    add_column :users, :otp_verified_at, :datetime
  end
end
