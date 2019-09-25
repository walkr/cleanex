# Cleanex

Clean up your Elixir terms.

By default it cleans strings (or any string values found inside maps, lists, keyword lists) by trimming ends, replacing double+ spaces, removing null-bytes; useful when working with user input.


### Installation

```elixir
def deps do
  [
    {:lib_cleanex, "~> 0.3.0"}
  ]
end
```


### Usage

As function

```elixir
iex> Cleanex.clean(" hello   world ")
"hello world"

iex> Cleanex.clean(%{greeting: "  hello   world  "})
%{greeting: "hello world"}

iex> Cleanex.clean {" k ", " v "}
{"k", "v"}
```

As plug for cleaning `conn.params`

```elixir
pipeline :api do
  ...
  plug Cleanex.Plugs.ParamsCleaner
  ...
end
```

#### Plug Options

`[strict: bool]` -- when `strict` is set to `false`, inner whitespace
won't be touched (default `true`)


### Extend

To extend just implement `Cleanex.Cleanable` protocol for your own types.

MIT Licensed