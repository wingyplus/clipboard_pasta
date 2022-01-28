defmodule Clipboard.NIF do
  use Rustler, otp_app: :clipboard, crate: "clipboard_nif"

  def copy(_content), do: :erlang.nif_error(:nif_not_loaded)

  def paste(), do: :erlang.nif_error(:nif_not_loaded)
end
