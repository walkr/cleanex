defmodule Cleanex do
  @doc """
  Clean a term by invoking the Cleanable protocol
  """
  def clean(term), do: __MODULE__.Cleanable.clean(term)
end
