defmodule DiscussWeb.TopicHTML do
  use DiscussWeb, :html

  # import Phoenix.HTML.Form
  # use Phoenix.Router

  # def topic_path(conn, :create) do
  #   DiscussWeb.Router.Helpers.topic_path(conn, :create)
  # end

  # def topic_path(conn, :new) do
  #   DiscussWeb.Router.Helpers.topic_path(conn, :new)
  # end

  # def topic_path(conn, :update, topic) do
  #   DiscussWeb.Router.Helpers.topic_path(conn, :update, topic)
  # end

  embed_templates "topic_html/*"
end
