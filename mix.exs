defmodule Cleanex.MixProject do
  use Mix.Project

  def project do
    [
      app: :cleanex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "Cleanex",
      description: "Clean up your Elixir terms",
      source_url: "https://github.com/walkr/cleanex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: []

  # Run "mix help deps" to learn about dependencies.
  defp deps, do: []

  defp package do
    [
      name: "cleanex",
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG*"],
      license: "MIT License",
      links: %{"GitHub" => "https://github.com/walkr/cleanex"}
    ]
  end
end
