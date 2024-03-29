defmodule DiscussWeb.UserSocket do
  use Phoenix.Socket

  channel "comments:*", DiscussWeb.CommentsChannel
  # channel "comments:*", DiscussWeb.CommentsChannel
  # get "comments/:id" ,CommentController, :join
  # Before (deprecated):
  transport(:websocket, Phoenix.Transports.WebSocket)

  # After:
  # transport(self(), :websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
