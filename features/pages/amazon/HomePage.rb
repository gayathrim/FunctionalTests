class HomePage

  URL ="http://www.amazon.com/"
  SEARCH_TEXT_BOX="twotabsearchtextbox"

  def initialize(session)
    @session=session
  end

  def launch_home_page
    @session.visit URL
  end

  def go_to_sign_in_page
    @session.click_link "Sign in"
  end

  def search_for(product)
    @session.fill_in SEARCH_TEXT_BOX, :with => product
    @session.click_on "Go"
  end
end