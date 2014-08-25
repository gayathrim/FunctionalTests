class InboxPrimaryPage

  EMAIL_FROM_AMAZON="Gayathri M wants you to see this item at Amazon.com"
  EMAIL_CONTENT_SHARED="//tr[td/a[contains(.,'Learn more')]]/preceding-sibling::tr"

  def initialize(session)
    @session=session
  end

  def wait_for_inbox_to_load
    time=10
    until @session.has_css?(".aKz")|(time==0)
      sleep(2)
      time=time-2
    end
  end

  def open_email_from_amazon
    wait_for_inbox_to_load
    @session.find("span", :text => EMAIL_FROM_AMAZON).click
  end

  def collect_product_info_from_mail
    @session.find(:xpath, EMAIL_CONTENT_SHARED).text
  end

  def get_product_link_from_email
    return @session.find("a", :text =>"Learn more")[:href]
  end
end