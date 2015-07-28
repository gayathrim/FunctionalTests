class CommonPage

  def initialize(session)
    @session=session
    @scenario=0
  end

  def enter_text(element_locator, product)
    @session.fill_in element_locator, :with => product
  end

  def visit(url)
    @session.visit url
  end

  def click_link(link)
    @session.click_link link
  end

  def click_on(element)
    @session.click_on element
  end

  def get_text(element)
    find_element(element).text
  end

  def find_element(element)
    @session.find(element)
  end

  def click_on_first_link(element)
    @session.find(:css, element).first("a").click
  end

  def find_within_and_click(scope, element)
    @session.within scope do
      @session.find(:css, element).click
    end
  end

  def page_has_content?(content)
    @session.has_content?(content)
  end

  def capture_screenshot
    screenshot_name="Screenshot_"+ @scenario.to_s
    @session.save_screenshot screenshot_name+".png"
    FileUtils.mv("./#{screenshot_name}.png", File.join(File.dirname(__FILE__), "..", "..", "output"))
    @scenario=@scenario+1
  end
end
