defmodule Cleanex do
  @doc "Clean a term by invoking the Cleanable protocol"
  @spec clean(term, keyword) :: term
  def clean(term, opts \\ []), do: __MODULE__.Cleanable.clean(term, opts)
end
