defmodule Cookpod.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 4)
    |> validate_confirmation(:password, message: "does not match password")
    |> encrypt_password()
    |> unique_constraint(:email)
    |> validate_email(:email)
  end

  def new_changeset() do
    changeset(%Cookpod.User{}, %{})
  end

  def validate_email(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, email ->
      email_valid =
        email
        |> String.split("@")
        |> Enum.count(fn el -> String.length(el) > 0 end)
        |> (fn len -> len == 2 end).()

      case email_valid do
        true ->
          []

        false ->
          [{field, options[:message] || "Bad email format"}]
      end
    end)
  end

  def encrypt_password(changeset) do
    case Map.fetch(changeset.changes, :password) do
      {:ok, password} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))

      :error ->
        changeset
    end
  end
end
