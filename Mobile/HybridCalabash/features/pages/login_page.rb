class LoginPage < CommonPage

  USER_NAME="input[name=firstName]"
  PASSWORD="input[type=password]"
  PAGE_TITLE="Entra"
  LOGIN_BUTTON="#login"
  REGISTER_ONLINE_TEXT="Se non sei registrato o per recuperare la tua password, visita il sito"
  COOP_LINK=""

  def verify_login_page_elements()
    wait_for_login_page_to_load()
    verify_text_in_webview(PAGE_TITLE)
    verify_element_present(PASSWORD)
    verify_element_present(LOGIN_BUTTON)
    verify_back_button_present
    verify_element_has_text(LOGIN_BUTTON,"Entra")
  end

  def verify_username_has_placeholder(place_holder_text)
    verify_place_holder_text(USER_NAME, place_holder_text)
  end

  def verify_password_has_placeholder(place_holder_text)
    verify_place_holder_text(PASSWORD, place_holder_text)
  end

  def verify_splash_screen_present(expectedActivity)
    verify_activity_present(expectedActivity)
  end

  def wait_for_login_page_to_load()
    wait_for_progress_to_disappear
    wait_for_element_to_be_present([USER_NAME], {timeout_message: "Login Page failed to Load"})
  end

  def enter_user_credentials(username, password)
    enter_text_on_webview_element(USER_NAME, username)
    enter_text_on_webview_element(PASSWORD, password)
  end

  def click_login
     touch_element(LOGIN_BUTTON)
  end

  def verify_register_online_text_present()
    verify_text_in_webview(REGISTER_ONLINE_TEXT)
  end

  def verify_register_online_text
    verify_text_in_webview(REGISTER_ONLINE_TEXT)
    #verify_element_present(COOP_LINK)
  end

  def go_back
    touch_back
    return WelcomePage.new
  end
end