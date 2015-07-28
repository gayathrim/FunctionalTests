class CommonPage

  include PageBaseOperations

  BACK_BUTTON=".back-button"
  SUB_TITLE=".sub-title-label"
  INLINE_ERROR=".x-list-emptytext"
  ITALIAN_MONTHS=%w/Gennaio Febbraio Marzo	Aprile	Maggio	Giugno	Luglio	Agosto	Aettembre	Ottobre	Novembre Dicembre/

  def touch_back
    touch_element(BACK_BUTTON)
  end

  def wait_for_app_load
    if ENV['PLATFORM'] == 'android'
      page_load= false
      time_out =40
      query_element="WLWebView css:'#signInButton'"
      until (time_out.zero?|page_load)
        sleep(2)
        page_load=element_exists(query_element)
        time_out=time_out-2
      end
    end
  end

  def verify_back_button_present
    verify_element_present(BACK_BUTTON)
  end

  def embed(dummy1, dummy2, dummy3)
    return
  end

  def wait_for_loading_icon_to_disappear
    wait_for_progress_to_disappear
  end

  def verify_error_msg_in_popup(error_msg)
    verify_message_in_native_popup(error_msg)
  end

  def touch_ok_on_store_popup
    #calabash has the defect when the geo coordinates are set and then error popup comes, the app stills. Hence need to dismiss the popup immediately.
    dismiss_err_popup
  end

  def touch_ok_on_popup
    sleep(1)
    dismiss_err_popup
  end

  def touch_cancel_on_popup
  sleep(1)
  dismiss_decline_err_popup
  end
  
  def select_item_in_list(name, itemCls)
    element_id=get_element_id_in_list(name, itemCls)
    touch_element("##{element_id}")
  end

  def scroll_till_I_find(text)
    wait_for(:timeout => 10) do
      swipe_up_on_page
      list_visible=get_list_values
      p "After swipe: #{list_visible}"
      list_visible.any? { |value| value.include?("#{text}") }
    end
  end

  def get_italian_month(month_in_number)
    return ITALIAN_MONTHS[month_in_number-1]
  end

  def verify_last_updated_date(expected_date)
    date_array=expected_date.split("/")
    date_in_italian=date_array[0]+" #{get_italian_month(date_array[1].to_i)}"+" "+date_array[2]
    verify_element_has_text(SUB_TITLE, "Ultimo aggiornamento"+date_in_italian)
  end

  def get_chronic_parsed_date(chronic_date)
    DateTime.parse(Chronic.parse(chronic_date).to_s.split[0]).strftime("%d/%m/%Y").to_s
  end

  def touch_first_item_in_list
    touch_element(".x-list-item-first")
  end

  def click_refresh
    touch_element(".reload-page")
  end

  def swipe_and_get_all_contents
    cleanList = Hash.new
    endOfList = false

    while !endOfList
      endOfList = is_last_list_element_visible_now?
      listItems= get_raw_list_values
      if(listItems.empty?)
        break
      else
          listItems.each { | listItem | cleanList[listItem["id"]] = listItem["textContent"].to_s }
          swipe_up_on_page
      end
    end
    cleanList
  end

  def verify_inline_error_msg(err_msg)
    verify_element_has_text(INLINE_ERROR, err_msg)
  end

  def enter_scan_text(code)
    set_text_in_native_text_field(code)
  end

  def wait_for_scan_page_to_load
    wait_for(:timeout => 5) { element_exists("textField") }
  end

end