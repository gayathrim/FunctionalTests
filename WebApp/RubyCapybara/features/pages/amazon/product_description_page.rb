require_relative "../common_page"

class ProductDescriptionPage <CommonPage

  PRODUCT_TITLE="#productTitle"
  BRAND="#brand"
  AVERAGE_RATING="#acrPopover"
  PRICE="#priceblock_ourprice"
  SHIPPING_TYPE="#ourprice_shippingmessage"
  COLOR="#variation_color_name"
  FEATURES="#feature-bullets ul"
  SHARE_BY_EMAIL="swfText"
  EMAIL_TO="ac_input"
  COPY_ME_CHECKBOX="Send me a copy of this Email"
  SEND_EMAIL_BUTTON="Send e-mail"

  def initialize session
    super(session)
  end

  def collect_product_unique_details
    title=get_text(PRODUCT_TITLE)
    brand=get_text(BRAND)
    rating=get_text(AVERAGE_RATING)
    price=get_text(PRICE)
    shipping=get_text(SHIPPING_TYPE)
    color=get_text(COLOR)
    features=get_text(FEATURES)

    product_details={:title => title, :brand => brand, :rating => rating, :price => price,
    :shipping => shipping, :color => color, :features => features}

    return product_details

  end

  def share_by_email_to(email)
    click_on SHARE_BY_EMAIL
    email_content=get_text("#formInThePopUp .a-span9")
    enter_text(EMAIL_TO, email)
    click_on SEND_EMAIL_BUTTON
    return email_content
  end
end