require_relative "../common_page"

class SignInPage<CommonPage

  URL = "https://www.amazon.com/ap/signin?_encoding=UTF8&openid.assoc_handle=usflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2Fgp%2Fyourstore%2Fhome%3Fie%3DUTF8%26ref_%3Dnav_signin"

  def initialize(session)
     super(session)
  end

  def goto_sign_in_page
    visit URL
  end

  def sign_in_with_credentials(email, password)
    if page_has_content?("Your Account")
      enter_text "ap_email", email
      enter_text "ap_password", password
      click_on "Sign in using our secure server "
    else
      enter_text "auth-email", email
      enter_text "auth-password", password
      find_within_and_click('.a-spacing-extra-large', '.a-button-input')
    end
  end

end