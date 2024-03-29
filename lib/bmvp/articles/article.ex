defmodule Bmvp.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  import Money.Validate

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field(:content, :string)
    field(:title, :string)
    field(:author_id, :binary_id)

    field(
      :price,
      Money.Ecto.Composite.Type,
      default_currency: :EUR,
      default: Money.new(:EUR, "1.50")
    )

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :content, :price, :author_id])
    |> validate_required([:title, :content, :price, :author_id])
    |> validate_money(:price, greater_than_or_equal_to: Money.new(:EUR, "1.00"))
    |> validate_money(:price, less_than_or_equal_to: Money.new(:EUR, "100.00"))
  end
end
