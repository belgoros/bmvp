defmodule BmvpWeb.OverviewLive do
  alias Bmvp.Articles
  use BmvpWeb, :live_view
  alias Bmvp.Accounts
  alias(Bmvp.Articles)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="py-24 bg-white sm:py-32">
      <div class="px-6 mx-auto max-w-7xl lg:px-8">
        <div class="max-w-2xl mx-auto lg:mx-0">
          <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">
            From the blog of <%= @author.username %>
          </h2>
        </div>
        <div class="grid max-w-2xl grid-cols-1 pt-10 mx-auto mt-10 border-t border-gray-200 gap-x-8 gap-y-16 sm:mt-16 sm:pt-16 lg:mx-0 lg:max-w-none lg:grid-cols-3">
          <%= for article <- @articles do %>
            <article class="flex flex-col items-start justify-between max-w-xl">
              <div class="flex items-center text-xs gap-x-4">
                <time datetime="2020-03-16" class="text-gray-500"><%= article.updated_at %></time>
              </div>
              <a href={~p"/articles/#{article.id}"}>
                <div class="relative group">
                  <h3 class="mt-3 text-lg font-semibold leading-6 text-gray-900 group-hover:text-gray-600">
                    <span class="absolute inset-0"></span> <%= article.title %>
                  </h3>
                  <p class="mt-5 text-sm leading-6 text-gray-600 line-clamp-3">
                    <%= String.slice(article.content, 0, 200) %>
                  </p>
                </div>
              </a>
            </article>
          <% end %>
          <!-- More posts... -->
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(%{"username" => username}, _session, socket) do
    with {:ok, author} <- Accounts.get_user_by_username(username),
         articles <- Articles.list_articles_by_author_id(author.id) do
      {:ok, assign(socket, author: author, articles: articles)}
    else
      _error ->
        {:ok, assign(socket, author: nil, articles: [])}
    end
  end
end
