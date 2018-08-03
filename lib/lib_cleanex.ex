defmodule Cleanex do
  @doc "Clean a term by invoking the Cleanable protocol"
  @spec clean(term) :: term
  def clean(term), do: __MODULE__.Cleanable.clean(term)
end
