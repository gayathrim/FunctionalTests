require_relative "../common_page"

class SearchListPage<CommonPage

  def initialize(session)
    super(session)
  end

  def select_first_product_on_list
    click_on_first_link "#result_1"
  end

end