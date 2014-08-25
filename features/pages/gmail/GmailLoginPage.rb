class GmailLoginPage

  URL="http://mail.google.com/"
  EMAIL="Email"
  PASSWORD="Passwd"
  SIGN_IN_BUTTON="signIn"

  def initialize session
    @session=session
  end

  def goto_gmail_login
    @session.visit URL
  end

  def sign_in_with_credentials(email, password)
    @session.fill_in EMAIL, :with => email
    @session.fill_in PASSWORD, :with => password
    @session.click_on SIGN_IN_BUTTON
  end
end