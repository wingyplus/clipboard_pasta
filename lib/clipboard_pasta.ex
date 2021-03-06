defmodule ClipboardPasta do
  @moduledoc """
  Clipboard module provides a set of functions to copy/paste OS clipboard.
  """

  alias ClipboardPasta.NIF

  @doc """
  Copy `term` into clipboard.

  The function will convert `term` into a string content when the `term` is
  not a binary. Add `:pretty` to the `opts` to copy with pretty structure.

  ## Examples

      iex> ClipboardPasta.copy("Hello")
      :ok
      iex> ClipboardPasta.copy({:ok, "Hello"})
      :ok
      iex> ClipboardPasta.paste()
      {:ok, "{:ok, \\"Hello\\"}"}
  """
  @spec copy(term(), Keyword.t()) :: :ok | :error
  def copy(term, opts \\ []) do
    term
    |> to_binary(opts)
    |> NIF.copy()
  end

  @doc """
  Similar to `copy/2` but return `term` instead.

  ## Examples

      iex> [1, 2, 3] |> ClipboardPasta.copy_tap()
      [1, 2, 3]
      iex> ClipboardPasta.paste()
      {:ok, "[1, 2, 3]"}
  """
  @spec copy_tap(term(), Keyword.t()) :: term()
  def copy_tap(term, opts \\ []) do
    term
    |> tap(&copy(&1, opts))
  end

  defp to_binary(term, opts) do
    inspect(term, pretty: opts[:pretty] || false)
  end

  @doc """
  Get the content from clipboard.

  ## Examples

      iex> ClipboardPasta.copy("Hello")
      :ok
      iex> ClipboardPasta.paste()
      {:ok, "\\"Hello\\""}
  """
  @spec paste() :: {:ok, String.t()} | :error
  def paste(), do: NIF.paste()
end
