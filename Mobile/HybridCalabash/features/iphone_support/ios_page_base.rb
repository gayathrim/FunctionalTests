module PageBaseOperations
  include Calabash::Cucumber::Operations
  include Calabash::Cucumber::Core
  include Calabash::Cucumber::Location

  def verify_text_in_webview(text)
    html_body=query("webView css:'*'")
    if (html_body.include?(text)==nil) then
      raise "Text not found in html"
    end
  end

  def verify_place_holder_text(element, text)
    result= query("webView css:'#{element}'")
    placeholder_field="placeholder=\"#{text}\""
    if (result[0]["html"].match(placeholder_field)==nil) then
      raise "Placeholder not found in html"
    end
  end

  def verify_element_has_text(element, text)
    result= query("webView css:'#{element}'").first["textContent"]
    if (result!="#{text}") then
      raise "TextContent #{text} not found"
    end
  end

  def get_all_text_with_css(css)
    result=query("webView css:'#{css}'")
    list_of_text = result.collect { |element| element["textContent"] }
  end

  def wait_for_element_to_be_present(element, options={})
    query_element=element.collect { |element| "webView css:'#{element}'" }
    wait_for_elements_exist(query_element, options)
  end

  def verify_element_present(element)
    raise "#{element} does not exist" unless element_exists("webView css:'#{element}'")
  end

  def verify_element_not_present(element)
    raise "#{element} exists" unless element_does_not_exist("webView css:'#{element}'")
  end

  def touch_element(element)
    touch("webView css:'#{element}'")
  end

  def enter_text_on_webview_element(element, text)
    touch("webView css:'#{element}'")
    keyboard_enter_text(text)
    result=query("button marked:'Done'")
    if (result!=[])
      touch("button marked:'Done'")
    end
  end

  def select_from_dropdown(dropdown_element, item_text)
    touch("webView css:'#{dropdown_element}'")
    sleep(2)
    touch_element_with_text(".x-dataview-item", item_text)
    touch_element_with_text(".x-picker .x-button", "Done")
  end

  def touch_element_with_text(element, text)
    touch("webView css:'#{element}' textContent:'#{text}'")
  end

  def verify_button_activeness(bool)
    result=query("webView css:'#{element}'", :enabled)
    if (result[0]!=bool) then
      raise "Button enabled parameter is expected to be #{bool}"
    end
  end

  def verify_message_in_native_popup(error_msg)
    wait_for_elements_exist(["view:'UIAlertView'"])
    wait_for_elements_exist(["view:'UIAlertView' label text:'OK'"])
    element=query("view:'UIAlertView'", :message)
    raise "Couldnot find error popup with message #{error_msg}" unless (error_msg==element[0])
  end

  def wait_for_error_popup_to_dismiss
    wait_for_elements_do_not_exist(["view:'UIAlertView'"])
    sleep(1)
  end

  def wait_for_progress_to_disappear
    wait_for_elements_do_not_exist(["webView css:'.progress-bar'"])
  end

  def get_position_by_text_in_list(text)
    result= query("webView css:'.x-list-item'").collect { |list_elements| list_elements["textContent"] }
    hash = Hash[result.map.with_index.to_a]
    hash[text]+1
  end

  def get_element_id_in_list(text, itemCls)
    result= query("webView css:'#{itemCls}'").collect { |list_elements| {list_elements["textContent"] => list_elements["id"]} }
    p result
    result.each do |hash_map|
      if (hash_map.has_key?(text))
        return hash_map["#{text}"]
      end
    end
  end

  def get_list_values
    result= query("webView css:'.x-list-item'").collect { |list_elements| list_elements["textContent"] }
  end

  def get_raw_list_values
    listItems= query("webView css:'.x-list-item'")
  end

  def get_element_in_list_by_text(text)
    element_position= get_position_by_text_in_list(text)
    p element_position
    query("webView css:'.x-list-item'")[element_position-1]
  end

  def wait_for_element_to_have_text(element)
    time_out=10
    until (!(query("webView css:'#{element}'").first["textContent"].empty? & time_out==0))
      sleep(2)
      time_out-=2
    end
    raise "Text missing" unless !(query("webView css:'#{element}'").first["textContent"].empty?)
  end

  def set_geo_coordinates(latitude, longitude)
    set_location(:latitude => latitude, :longitude => longitude)
    sleep(4)
  end

  def swipe_up_on_page
    swipe(:up, {:query => "webView css:'.x-scroll-view'"})
  end

  def is_last_list_element_visible_now?
    result= element_exists("webView css:'.x-list-item-last'")
  end

  def return_elements_with_identifier(identifier)
    query("webView css:'#{identifier}'")
  end

  def touch_nth_element_of(identifier, index)
    elements=return_elements_with_identifier(identifier)
    touch(elements[index])
  end

  def dismiss_err_popup
    touch("view:'UIAlertView' label text:'OK'")
  end

  def dismiss_decline_err_popup
    touch("view:'UIAlertView' label text:'Annulla'")
  end

  def set_text_in_native_text_field(text)
    set_text("textField", text)
    sleep(2) #Adding sleep because of a inhibition to touch after a set_text with calabash-ios
    touch("textField")
    wait_for(:timeout => 5) { element_exists("button label text:'Avanti'") }
    touch("button label text:'Avanti'")
  end

end