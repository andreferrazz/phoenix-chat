defmodule PhoenixChatWeb.RoomChannel do
  @moduledoc """
  Define callbacks to handle clients connections and messages
  """

  use Phoenix.Channel

  require Logger

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorize"}}
  end

  def handle_in("new_msg", %{"message" => message}, socket) do
    %{"sender" => sender, "text" => text, "date" => date} = message

    broadcast!(
      socket,
      "new_msg",
      %{message: %{"sender" => sender, "text" => text, "date" => date}}
    )

    {:noreply, socket}
  end
end
