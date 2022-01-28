defmodule Clipboard do
  @moduledoc """
  Clipboard module provides a set of functions to copy/paste OS clipboard.
  """

  alias Clipboard.NIF

  @doc """
  Copy `content` into clipboard.

  ## Examples

      iex> Clipboard.copy("Hello")
      :ok
  """
  @spec copy(String.t()) :: :ok | :error
  def copy(content) when is_binary(content), do: NIF.copy(content)

  @doc """
  Get the content from clipboard.

  ## Examples

      iex> Clipboard.copy("Hello")
      :ok
      iex> Clipboard.paste()
      {:ok, "Hello"}
  """
  @spec paste() :: {:ok, String.t()} | :error
  def paste(), do: NIF.paste()
end
