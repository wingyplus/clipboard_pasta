defmodule Clipboard do
  @moduledoc """
  Clipboard module provides a set of functions to copy/paste OS clipboard.
  """

  alias Clipboard.NIF

  @doc """
  Copy `term` into clipboard.

  The function will convert `term` into a string content when the `term` is
  not a binary. Add `:pretty` to the `opts` to copy with pretty structure.

  ## Examples

      iex> Clipboard.copy("Hello")
      :ok
      iex> Clipboard.copy({:ok, "Hello"})
      :ok
      iex> Clipboard.paste()
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

      iex> [1, 2, 3] |> Clipboard.copy_tap()
      [1, 2, 3]
      iex> Clipboard.paste()
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

      iex> Clipboard.copy("Hello")
      :ok
      iex> Clipboard.paste()
      {:ok, "\\"Hello\\""}
  """
  @spec paste() :: {:ok, String.t()} | :error
  def paste(), do: NIF.paste()
end
