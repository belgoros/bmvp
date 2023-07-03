defmodule BmvpWeb.Component.EmptyState do
  use BmvpWeb, :html

  attr(:text, :string, required: true)
  attr(:image, :string, required: true)

  def show(assigns) do
    ~H"""
    <div>
      <h2 class="text-2xl font-semibold tracking-tight sm:text-center sm:text-lg">
        <%= @text %>
      </h2>
      <div class="w-full max-w-xs mx-auto mt-10">
        <img
          src={~p"/images/#{@image}"}
          alt=""
          class="w-full rounded-xl ring-1 ring-gray-400/10 max-w-none md:-ml-4 lg:-ml-0"
        />
      </div>
    </div>
    """
  end
end
