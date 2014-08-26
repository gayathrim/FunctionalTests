class ProductDescriptionPage

  PRODUCT_TITLE="#productTitle"
  BRAND="#brand"
  AVERAGE_RATING="#ratingStars"
  PRICE="#priceblock_ourprice"
  SHIPPING_TYPE="#ourprice_shippingmessage"
  COLOR="#variation_color_name"
  FEATURES="#feature-bullets ul"
  SHARE_BY_EMAIL="swfText"
  EMAIL_TO="ac_input"
  COPY_ME_CHECKBOX="Send me a copy of this Email"
  SEND_EMAIL_BUTTON="Send e-mail"

  def initialize session
    @session = session
  end

  def collect_product_unique_details
    title=@session.find(PRODUCT_TITLE).text
    brand=@session.find(BRAND).text
    rating=@session.find(AVERAGE_RATING).text
    price=@session.find(PRICE).text
    shipping=@session.find(SHIPPING_TYPE).text
    color=@session.find(COLOR).text
    features=@session.find(FEATURES).text

    product_details={:title => title, :brand => brand, :rating => rating, :price => price,
    :shipping => shipping, :color => color, :features => features}

    return product_details

  end

  def share_by_email_to(email)
    @session.click_on SHARE_BY_EMAIL
    email_content=@session.find("#formInThePopUp .a-span9").text
    @session.fill_in EMAIL_TO, :with => email
    @session.uncheck COPY_ME_CHECKBOX
    @session.click_on SEND_EMAIL_BUTTON
    return email_content
  end
end