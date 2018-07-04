defmodule Gexbot.Auth do
  alias Gexbot.Github.Event
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Gexbot.Repo

  alias Gexbot.Auth.Installation

  @doc """
  Returns the list of installations.

  ## Examples

      iex> list_installations()
      [%Installation{}, ...]

  """
  def list_installations do
    Repo.all(Installation)
  end

  @doc """
  Gets a single installation.

  Raises `Ecto.NoResultsError` if the Installation does not exist.

  ## Examples

      iex> get_installation!(123)
      %Installation{}

      iex> get_installation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_installation!(id), do: Repo.get!(Installation, id)

  @doc """
  Creates a installation from an integration_installation event

  ## Examples

      iex> create_installation(event)
      {:ok, %Installation{}}

      iex> create_installation(event)
      {:error, %Ecto.Changeset{}}

  """
  def create_installation(%Event{event: "integration_installation"} = event) do
    %{}
      |> Map.put(:installation_id, get_in(event.data, ["installation", "id"]) |> Integer.to_string)
      |> Map.put(:username, get_in(event.data, ["installation", "account", "login"]))
      |> Map.put(:permissions, get_in(event.data, ["installation", "permissions"]))
      |> Map.put(:events, get_in(event.data, ["installation", "events"]))
      |> Map.put(:installed_by, get_in(event.data, ["sender", "login"]))
      |> create_installation
  end

  @doc """
  Creates a installation.

  ## Examples

      iex> create_installation(%{field: value})
      {:ok, %Installation{}}

      iex> create_installation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_installation(attrs \\ %{}) do
    %Installation{}
    |> Installation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a installation.

  ## Examples

      iex> update_installation(installation, %{field: new_value})
      {:ok, %Installation{}}

      iex> update_installation(installation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_installation(%Installation{} = installation, attrs) do
    installation
    |> Installation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Installation.

  ## Examples

      iex> delete_installation(installation)
      {:ok, %Installation{}}

      iex> delete_installation(installation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_installation(%Installation{} = installation) do
    Repo.delete(installation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking installation changes.

  ## Examples

      iex> change_installation(installation)
      %Ecto.Changeset{source: %Installation{}}

  """
  def change_installation(%Installation{} = installation) do
    Installation.changeset(installation, %{})
  end

  alias Gexbot.Auth.Authorization

  @doc """
  Returns the list of authorizations.

  ## Examples

      iex> list_authorizations()
      [%Authorization{}, ...]

  """
  def list_authorizations do
    Repo.all(Authorization)
  end

  @doc """
  Gets a single authorization.

  Raises `Ecto.NoResultsError` if the Authorization does not exist.

  ## Examples

      iex> get_authorization!(123)
      %Authorization{}

      iex> get_authorization!(456)
      ** (Ecto.NoResultsError)

  """
  def get_authorization!(id), do: Repo.get!(Authorization, id)

  @doc """
  Creates a authorization.

  ## Examples

      iex> create_authorization(%{field: value})
      {:ok, %Authorization{}}

      iex> create_authorization(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_authorization(attrs \\ %{}) do
    %Authorization{}
    |> Authorization.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a authorization.

  ## Examples

      iex> update_authorization(authorization, %{field: new_value})
      {:ok, %Authorization{}}

      iex> update_authorization(authorization, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_authorization(%Authorization{} = authorization, attrs) do
    authorization
    |> Authorization.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Authorization.

  ## Examples

      iex> delete_authorization(authorization)
      {:ok, %Authorization{}}

      iex> delete_authorization(authorization)
      {:error, %Ecto.Changeset{}}

  """
  def delete_authorization(%Authorization{} = authorization) do
    Repo.delete(authorization)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking authorization changes.

  ## Examples

      iex> change_authorization(authorization)
      %Ecto.Changeset{source: %Authorization{}}

  """
  def change_authorization(%Authorization{} = authorization) do
    Authorization.changeset(authorization, %{})
  end

  alias Gexbot.Auth.Person

  @doc """
  Returns the list of people.

  ## Examples

      iex> list_people()
      [%Person{}, ...]

  """
  def list_people do
    Repo.all(Person)
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get_person!(123)
      %Person{}

      iex> get_person!(456)
      ** (Ecto.NoResultsError)

  """
  def get_person!(id), do: Repo.get!(Person, id)

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{source: %Person{}}

  """
  def change_person(%Person{} = person) do
    Person.changeset(person, %{})
  end
end
