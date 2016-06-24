defmodule Ampex.Mixfile do
  use Mix.Project

  def project do
    [app: :ampex,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.8.3"},
    {:sweet_xml, "~> 0.6.1"}]
  end

  defp description do
    """
    Elixir Library for interacting with Amazon Product Advertising API
    """
  end

  defp package do
    [name: :ampex,
     maintainers: ["Thomas Geselle"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/tgeselle/ampex"}]
  end
end
