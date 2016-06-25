defmodule Ampex.ItemSearch do
  import SweetXml
  alias Process
  alias Ampex.Utils

  @base_url "http://webservices.amazon.com/onca/xml"

  def find_position(asin, keywords, max_pages \\ 10, wait_call \\ 1100, page \\ 1, position \\ 0) do
    if(page <= max_pages) do
      unless(page == 1) do
        Process.sleep(wait_call)
      end

      html = api_call(keywords, page)
      asins = html.body |> xpath(~x"//ItemSearchResponse/Items/Item"l, asin: ~x"./ASIN/text()")

      found = Enum.find_index(asins, fn(x) -> to_string(x.asin) == asin end)

      if(found == nil) do
        position = page * 10
        page = page + 1
        find_position(asin, keywords, max_pages, wait_call, page, position)
      else
        position = ((page - 1) * 10) + found + 1
      end
    else
      ">100"
    end
  end

  def api_call(keywords, page) do
    HTTPoison.start
    html = HTTPoison.get! generate_query(keywords, page)
  end

  def generate_query(keywords, page) do
    params_string = Ampex.Utils.combine_params(generate_params(keywords, page))
    signature = Ampex.Utils.sign_request(Enum.join(["GET", "webservices.amazon.com", "/onca/xml", params_string], "\n"))
    full_url = @base_url <> "?" <> params_string <> "&Signature=" <> signature
  end

  def generate_params(keywords, page) do
    %{
      "AssociateTag" => System.get_env("AWS_ASSOCIATE"),
      "AWSAccessKeyId" => System.get_env("AWS_KEY"),
      "Service" => "AWSECommerceService",
      "Version" => "2013-08-01",

      "Operation" => "ItemSearch",
      "Keywords" => keywords,
      "SearchIndex" => "All",
      "ItemPage" => to_string(page),
      "Timestamp" => Ampex.Utils.generate_timestamp
    }
  end
end
