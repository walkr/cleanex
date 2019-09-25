defprotocol Cleanex.Cleanable do
  @doc "Clean term"
  @fallback_to_any true
  def clean(_value, _opts)
end

defimpl Cleanex.Cleanable, for: Map do
  def clean(map, opts) do
    Enum.reduce(Map.keys(map), %{}, fn key, acc ->
      Map.put(acc, key, Map.fetch!(map, key) |> Cleanex.Cleanable.clean(opts))
    end)
  end
end

defimpl Cleanex.Cleanable, for: List do
  alias Cleanex.Cleanable

  def clean(list, opts) do
    list
    |> Enum.reduce([], fn val, acc -> [Cleanable.clean(val, opts) | acc] end)
    |> :lists.reverse()
  end
end

defimpl Cleanex.Cleanable, for: Tuple do
  def clean(tuple, opts) do
    tuple
    |> Tuple.to_list()
    |> Cleanex.clean(opts)
    |> List.to_tuple()
  end
end

defimpl Cleanex.Cleanable, for: BitString do
  @doc """
  Collapse multiple spaces into just one, and trim the ends
  """
  def clean(string, opts) do
    string

    # Get rid of null bytes
    |> String.replace("\0", "")

    # Trim ends
    |> String.trim()

    # Strict or not
    |> (fn s ->
          case Keyword.get(opts, :strict, true) do
            true ->
              s
              # Replace 2+ spaces with single space
              |> (fn s -> Regex.replace(~r/\s{2,}/, s, " ") end).()

            false ->
              s
          end
        end).()
  end
end

defimpl Cleanex.Cleanable, for: Atom do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Integer do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Float do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: PID do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Port do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Reference do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Function do
  def clean(value, _), do: value
end

defimpl Cleanex.Cleanable, for: Any do
  def clean(term, _), do: term
end
