require 'rails_helper'

describe User do
  describe 'pwned password validation check' do
    let(:user) { User.new(email: 'jo@example.com') }

    it 'is valid with a secure password', vcr: { cassette_name: 'secure-password' } do
      user.password = 'h!zpu!7mvCkRknbjUmrM'
      expect(user).to be_valid
    end

    it 'is invalid with an insecure password', vcr: { cassette_name: 'insecure-password' } do
      user.password = 'password'
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Password #{I18n.t('errors.messages.pwned_password')}"
    end
  end
end
