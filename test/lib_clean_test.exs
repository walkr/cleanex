defmodule CleanexTest do
  use ExUnit.Case
  doctest Cleanex

  test "clean string" do
    candidates = [
      "  hello  world  ",
      "hello    world\0",
      "  hello  \0  \0  world  "
    ]

    expect = "hello world"

    for c <- candidates do
      assert expect == Cleanex.clean(c)
    end
  end

  test "clean map" do
    map = %{name: "  hello    world "}
    assert %{name: "hello world"} == Cleanex.clean(map)
  end

  test "clean keyword list" do
    kws = [number: 23, name: "  hello    world  "]
    assert [number: 23, name: "hello world"] == Cleanex.clean(kws)
  end

  test "clean list tuples" do
    kws = [23, "  hello    world  "]
    assert [23, "hello world"] == Cleanex.clean(kws)

    kws = ["23 ", "  hello    world  "]
    assert ["23", "hello world"] == Cleanex.clean(kws)
  end

  test "clean tuple" do
    assert {"k", "v"} == Cleanex.clean({" k ", " v "})
    assert {"k", "v", "w"} == Cleanex.clean({" k ", " v ", " w "})
  end

  test "clean other types" do
    for t <- [:ok, self(), make_ref(), 1, 1.0, fn -> :ok end, Port.list() |> hd] do
      assert Cleanex.clean(t) === t
    end
  end

  test "any" do
    assert Cleanex.Cleanable.Any.clean(nil, []) == nil
  end
end
