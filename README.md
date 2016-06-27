# Ampex

Elixir Library for interacting with Amazon Product Advertising API

## Installation

Add `ampex` to your list of dependencies in `mix.exs`:

```elixir
  def deps do
    [{:ampex, "~> 0.1.0"}]
  end
```

## Config

Add these 3 environment variables to you system:

AWS_ASSOCIATE
AWS_KEY
AWS_SECRET

## Usage

### FindPosition

Find position of a product:
```elixir
  Ampex.find_position(asin, keywords, max_pages \\ 10, wait_call \\ 1100, page \\ 1, position \\ 0)
```

### ItemLookup

Only returns title and image:
```elixir
  Ampex.item_lookup(asin)
```
