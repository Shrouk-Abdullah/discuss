defmodule DiscussWeb.TopicHTML do
  use DiscussWeb, :html
  use Phoenix.HTML
  import Phoenix.HTML.Form
  use Phoenix.Router

  def topic_path(conn, :create) do
    DiscussWeb.Router.Helpers.topic_path(conn, :create)
  end

  embed_templates "topic_html/*"
end
