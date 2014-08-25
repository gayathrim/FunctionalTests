class SearchListPage

  def initialize(session)
    @session=session
  end

  def select_first_product_on_list
    @session.find(:css, "#result_1").first("a").click
  end

end