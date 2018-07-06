defmodule CleanexTest do
  use ExUnit.Case
  doctest Cleanex

  test "clean string" do
    candidates = ["  hello  world  ", "hello    world\0"]
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

  test "clean lists" do
    kws = [23, "  hello    world  "]
    assert [23, "hello world"] == Cleanex.clean(kws)
  end
end
