defmodule Ampex.ItemLookup do
  import SweetXml
  alias Ampex.Utils

  @base_url "http://webservices.amazon.com/onca/xml"

  def find_product(asin) do
    html = api_call(asin)
    html.body |> xpath(~x"//ItemLookupResponse/Items/Item", title: ~x"./ItemAttributes/Title/text()", image: ~x"./LargeImage/URL/text()")    
  end

  def api_call(asin) do
    HTTPoison.start
    html = HTTPoison.get! generate_query(asin)
  end

  def generate_query(asin) do
    params_string = Ampex.Utils.combine_params(generate_params(asin))
    signature = Ampex.Utils.sign_request(Enum.join(["GET", "webservices.amazon.com", "/onca/xml", params_string], "\n"))
    full_url = @base_url <> "?" <> params_string <> "&Signature=" <> signature
  end

  def generate_params(asin) do
    %{
      "AssociateTag" => System.get_env("AWS_ASSOCIATE"),
      "AWSAccessKeyId" => System.get_env("AWS_KEY"),
      "Service" => "AWSECommerceService",
      "Version" => "2013-08-01",

      "Operation" => "ItemLookup",
      "ItemId" => asin,
      "ResponseGroup" => "Medium",
      "Timestamp" => Ampex.Utils.generate_timestamp
    }
  end
end
