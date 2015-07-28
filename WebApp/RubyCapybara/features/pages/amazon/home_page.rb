require_relative "../common_page"

class HomePage < CommonPage

  URL ="http://www.amazon.com/"
  SEARCH_TEXT_BOX="twotabsearchtextbox"

  def initialize(session)
    super(session)
  end

  def launch_home_page
    visit URL
  end

  def go_to_sign_in_page
    click_link "Sign in"
  end

  def search_for(product)
    enter_text(SEARCH_TEXT_BOX, product)
    click_on "Go"
  end


end