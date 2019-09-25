defmodule Cleanex.TestPlug do
  use ExUnit.Case
  use Plug.Test

  defmodule TestPlug do
    import Plug.Conn

    def clean_me(conn, _opts) do
      "POST" = conn.method
      send_resp(conn, 200, "#{inspect(conn.params)}")
    end
  end

  defmodule Pipeline do
    use Plug.Builder
    import TestPlug

    plug Cleanex.Plugs.ParamsCleaner
    plug :clean_me
  end

  defmodule Pipeline2 do
    use Plug.Builder
    import TestPlug

    plug Cleanex.Plugs.ParamsCleaner, strict: false
    plug :clean_me
  end

  test "cleaned params" do
    data = %{"key" => " hello  \0  world.\n\nNew line. "}
    c = conn(:post, "/clean-me", data) |> Pipeline.call([])
    assert c.status == 200
    assert c.resp_body == "%{\"key\" => \"hello world. New line.\"}"
  end

  test "cleaned params strict = false" do
    data = %{"key" => " hello  \0  world.\n\nNew line. "}
    c = conn(:post, "/clean-me", data) |> Pipeline2.call([])
    assert c.status == 200
    assert c.resp_body == "%{\"key\" => \"hello    world.\\n\\nNew line.\"}"
  end
end
