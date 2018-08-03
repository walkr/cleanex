defmodule Cleanex.Plugs.ParamsCleaner do
  @moduledoc """
  A plug to clean `conn.params`

  ## Usage

      pipeline :api do
        ...
        plug Cleanex.Plug.ParamsCleaner
        ...
      end

  """
  def init(opts), do: opts

  def call(conn, _) do
    %{conn | params: Cleanex.clean(conn.params)}
  end
end
