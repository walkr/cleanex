# Cleanex

Clean up Elixir terms.

By default it cleans strings (or any string values found inside (maps, lists, keyword lists) by trimming ends, replacing double+ spaces, removing null-bytes; useful when working with user input.


### Installation

```elixir
def deps do
  [
    {:cleanex, git: "https://github.com/walkr/cleanex"}
  ]
end
```


### Usage

```elixir
iex> Cleanex.clean(" hello   world ")
"hello world"

iex> Cleanex.clean(%{greeting: "  hello   world  "})
%{greeting: "hello world"}
```


### Extend
To extend just implement `Cleanex.Cleanable` protocol for your own types.

MIT Licensed