# Secure User Accounts

This is an example Ruby on Rails 6 application with [Devise authentication](https://github.com/heartcombo/devise) and a Postgres database. It shows how to improve user account security with pwned password validation and two-factor authentication.

## Pwned password validation

The [pwned](https://github.com/philnash/pwned#pwned) gem and the [devise-pwned_password](https://github.com/michaelbanfield/devise-pwned_password#devisepwnedpassword) gem validate a user password against a dataset of [breached passwords](https://haveibeenpwned.com/Passwords).

## Two-factor authentication

Using the [The Ruby One Time Password Library](https://github.com/mdp/rotp#the-ruby-one-time-password-library) and a [QR code render library](https://www.npmjs.com/package/qrcode), a simple 2FA solution that supports authenticator apps like Google Authenticator is implemented.

For production, you may want to consider:
* Preventing a user enabling 2FA until their email address has been confirmed
* Preventing the disabling of 2FA until a user has verified their current password
* Emailing users when 2FA is enabled or disabled on their account
* Locking out a user when they fail to give a correct one time code after a certain number of attempts
* Encrypting OTP secrets in the database
* Providing recovery codes for users who lose access to their device or alternatively, providing a secure procedure for user accounts to be unlocked by support
* Add your application to the [Two Factor Auth](https://twofactorauth.org/) website by creating a [PR](github.com/2factorauth/twofactorauth). Once added to this site the password manager 1Password will show your site as supporting 2FA.
