defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  # @impl true
  # for first time communatcation
  def join(name, payload, socket) do
    IO.puts(name)
    {:ok, %{hey: "there"}, socket}
    # if authorized?(payload) do
    #   {:error, %{reason: "unauthorized"}}
    # else
    # end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # @impl true
  # # for any follow up communatcation
  # def handle_in("comments:hello", %{"hi" => hi}, socket) do
  #   # Do something meaningful with the received message
  #   IO.puts("Received hello message: #{hi}")

  #   # You can also broadcast this message to other connected clients if needed
  #   {:reply, socket}
  # end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comments:lobby).
  # @impl true
  # def handle_in("shout", payload, socket) do
  #   # broadcast(socket, "shout", payload)
  #   # {:noreply, socket}
  # end

  # # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
end
