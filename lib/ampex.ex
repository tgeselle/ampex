defmodule Ampex do
  alias Ampex.ItemSearch

  def find_position(asin, keywords, max_pages \\ 10, wait_call \\ 1100, page \\ 1, position \\ 0) do
    Ampex.ItemSearch.find_position(asin, keywords, max_pages, wait_call, page, position)
  end

  def item_lookup(asin) do
    Ampex.ItemLookup.find_product(asin)
  end
end
