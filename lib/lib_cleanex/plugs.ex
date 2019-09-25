defmodule Cleanex.Plugs.ParamsCleaner do
  @moduledoc """
  A plug to clean `conn.params`

  ## Usage

      pipeline :api do
        ...
        plug Cleanex.Plug.ParamsCleaner
        ...
      end

  ### Plug Options

    `[strict: bool]` -- when `strict` is set to `false`, inner whitespace
    won't be touched (default `true`)

  """
  def init(opts), do: opts

  def call(conn, opts) do
    %{conn | params: Cleanex.clean(conn.params, opts)}
  end
end
