defmodule Cleanex.MixProject do
  use Mix.Project

  def project do
    [
      app: :lib_cleanex,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      name: "Cleanex",
      description: "Clean up your Elixir terms",
      source_url: "https://github.com/walkr/lib_cleanex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: []

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [
      name: "lib_cleanex",
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG*"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/walkr/lib_cleanex"}
    ]
  end

  defp docs do
    [main: "README", extras: ["README.md": [title: "README"]]]
  end
end
