defmodule Cleanex.Plug.CleanParams do
  @moduledoc """
  A plug to clean `conn.params`

  ## Usage

      pipeline :api do
        ...
        plug Cleanex.Plug.CleanParams
        ...
      end

  """
  def init(opts), do: opts

  def call(conn, params) do
    %{conn | params: Cleanex.clean(conn.params)}
  end
end
