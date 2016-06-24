defmodule Ampex.Utils do
  def combine_params(params) do
    Enum.map_join(params, "&", &Ampex.Utils.pair/1)
  end

  def pair({k, v}) do
    URI.encode(Kernel.to_string(k), &URI.char_unreserved?/1) <>
    "=" <> URI.encode(Kernel.to_string(v), &URI.char_unreserved?/1)
  end

  def sign_request(string_to_sign) do
    Base.encode64(:crypto.hmac(:sha256, System.get_env("AWS_SECRET"), string_to_sign))
  end

  def generate_timestamp do
    DateTime.to_iso8601(DateTime.utc_now())
  end
end
