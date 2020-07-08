class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :pwned_password

  def otp_to_be_verified?
    otp_secret.present? && otp_verified_at.blank?
  end

  def otp_enabled?
    otp_secret.present? && otp_verified_at?
  end

  #################################################
  # see https://github.com/mdp/rotp#time-based-otps
  #################################################
  def enable_otp!
    update!(otp_secret: ROTP::Base32.random)
  end

  def disable_otp!
    update!(otp_secret: nil, otp_verified_at: nil)
  end

  def otp_verify?(otp)
    return unless otp_to_be_verified?
    last_otp_at_ts = otp_verify(otp)
    update!(otp_verified_at: Time.at(last_otp_at_ts)) if last_otp_at_ts
    last_otp_at_ts.present?
  end

  def otp_check?(otp)
    last_otp_at_ts = otp_verify(otp, last_otp_at_ts: last_otp_at&.to_i)
    update!(last_otp_at: Time.at(last_otp_at_ts)) if last_otp_at_ts
    last_otp_at_ts.present?
  end

  def otp_provisioning_uri
    return unless otp_to_be_verified?
    totp = ROTP::TOTP.new(otp_secret, issuer: 'SecureUserAccounts')
    totp.provisioning_uri(email)
  end

  private

  # see https://github.com/mdp/rotp#preventing-reuse-of-time-based-otps
  def otp_verify(otp, last_otp_at_ts: nil)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(otp, after: last_otp_at_ts)
  end
end
