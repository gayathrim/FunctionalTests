module PageBaseOperations

  include Calabash::Android::Operations

  def verify_text_in_webview(text)
    html_body=performAction('dump_body_html')['bonusInformation'][0]
    if(html_body.match(text)==nil) then raise "Text- #{text} not found in html" end
  end

  def verify_place_holder_text(element, text)
    result= query("WLWebView css:'#{element}'")
    placeholder_field="placeholder=\"#{text}\""
    if(result[0]["html"].match(placeholder_field)==nil) then raise "Placeholder not found in html" end
  end

  def verify_element_has_text(element,text)
    result= query("WLWebView css:'#{element}'").first["textContent"]
    if(result!="#{text}") then raise "TextContent #{text} not found" end
  end

  def get_all_text_with_css(css)
    result=query("WLWebView css:'#{css}'")
    list_of_text = result.collect {|element| element["textContent"]}
  end

 def verify_activity_present(expected_activity)
    actual_activity = performAction('get_activity_name')['message']
    raise "The current activity is #{actual_activity}" unless( actual_activity == expected_activity || actual_activity == expected_activity + 'Activity' )
  end

  def wait_for_element_to_be_present(element, options={})
    query_element=element.collect{|element| "WLWebView css:'#{element}'"}
    wait_for_elements_exist(query_element, options)
  end

  def verify_element_present(element)
    raise "#{element} does not exist" unless element_exists("WLWebView css:'#{element}'")
  end

  def verify_element_not_present(element)
    raise "#{element} exists" unless element_does_not_exist("WLWebView css:'#{element}'")
  end

  def touch_element(element)
    touch("WLWebView css:'#{element}'")
  end

  def enter_text_on_webview_element(element,text)
    performAction('enter_text_by_selector',"#{element}", text)
  end

  def select_from_dropdown(dropdown_element, item_text)
    touch("webView css:'#{dropdown_element}'")
    touch_element_with_text(".x-dataview-item",item_text)
    touch_element_with_text(".x-picker .x-button","Done")
  end

  def touch_element_with_text(element, text)
    touch("webView css:'#{element}' textContext:'#{text}'")
  end

  def verify_button_activeness(bool)
    result=query("WLWebView css:'#{element}'", :enabled)
    if(result[0]!=bool) then raise "Button enabled parameter is expected to be #{bool}" end
  end

  def verify_message_in_native_popup(error_msg)
    element="TextView id:'message'"
    wait_for_elements_exist([element])
    actual_msg=query(element,:text)[0]
    raise "Got #{actual_msg} instead of expected #{error_msg}" unless(actual_msg == error_msg)
  end

  def wait_for_error_popup_to_dismiss
    wait_for_elements_do_not_exist(["DialogTitle id:'alertTitle'"])
  end

  def wait_for_progress_to_disappear
    performAction('wait_for_no_progress_bars')
  end

  def get_position_by_text_in_list(text)
    result= query("WLWebView css:'.x-list-item'", :textContent)
    hash = Hash[result.map.with_index.to_a]
    p hash[text]
    hash[text]+1
  end

  def get_element_in_list_by_text(store_name)
    element_position= get_position_by_text_in_list(store_name)
    element=query("WLWebView css:'.x-list-item'")[element_position-1]
  end

  def get_element_id_in_list(text)
    result= query("WLWebView css:'.x-list-item'").collect{|list_elements| {list_elements["textContent"] =>list_elements["id"]}}
    p result
    result.each do |hash_map|
      if(hash_map.has_key?(text))
        return hash_map["#{text}"]
      end
    end
  end

  def get_list_values
    result= query("WLWebView css:'.x-list-item'", :textContent)
  end

  def get_raw_list_values
    listItems= query("WLWebView css:'.x-list-item'")
  end

  def wait_for_element_to_have_text(element)
    time_out=10
    until (!(query("WLWebView css:'#{element}'").first["textContent"].empty? & time_out==0))
      sleep(2)
      time_out-=2
    end
    raise "Text missing" unless !(query("WLWebView css:'#{element}'").first["textContent"].empty?)
  end

  def set_geo_coordinates(latitude, longitude)
    set_gps_coordinates(latitude, longitude)
    start_test_server_in_background
  end

  def swipe_up_on_page
    performAction('scroll_to','css','#mobilePaymentButton')
  end

  def is_last_list_element_visible_now?
    result= element_exists("WLWebView css:'.x-list-item-last'")
  end

  def return_elements_with_identifier(identifier)
   query("WLWebView css:'#{identifier}'")
  end

  def touch_nth_element_of(identifier, index)
    elements=return_elements_with_identifier(identifier)
    touch(elements[index])
  end

  def dismiss_err_popup
    touch("button")
  end

  def dismiss_decline_err_popup
    #touch("view:'UIAlertView' label text:'Annulla'")
  end

  def set_text_in_native_text_field(text)
    #set_text("textField",text)
    #touch("textField")
    #touch("button label text:'Avanti'")
  end
end