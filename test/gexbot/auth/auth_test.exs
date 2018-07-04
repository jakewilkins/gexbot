defmodule Gexbot.AuthTest do
  use Gexbot.DataCase

  alias Gexbot.Auth

  describe "installations" do
    alias Gexbot.Auth.Installation

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def installation_fixture(attrs \\ %{}) do
      {:ok, installation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_installation()

      installation
    end

    test "list_installations/0 returns all installations" do
      installation = installation_fixture()
      assert Auth.list_installations() == [installation]
    end

    test "get_installation!/1 returns the installation with given id" do
      installation = installation_fixture()
      assert Auth.get_installation!(installation.id) == installation
    end

    test "create_installation/1 with valid data creates a installation" do
      assert {:ok, %Installation{} = installation} = Auth.create_installation(@valid_attrs)
    end

    test "create_installation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_installation(@invalid_attrs)
    end

    test "update_installation/2 with valid data updates the installation" do
      installation = installation_fixture()
      assert {:ok, installation} = Auth.update_installation(installation, @update_attrs)
      assert %Installation{} = installation
    end

    test "update_installation/2 with invalid data returns error changeset" do
      installation = installation_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_installation(installation, @invalid_attrs)
      assert installation == Auth.get_installation!(installation.id)
    end

    test "delete_installation/1 deletes the installation" do
      installation = installation_fixture()
      assert {:ok, %Installation{}} = Auth.delete_installation(installation)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_installation!(installation.id) end
    end

    test "change_installation/1 returns a installation changeset" do
      installation = installation_fixture()
      assert %Ecto.Changeset{} = Auth.change_installation(installation)
    end
  end

  describe "authorizations" do
    alias Gexbot.Auth.Authorization

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def authorization_fixture(attrs \\ %{}) do
      {:ok, authorization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_authorization()

      authorization
    end

    test "list_authorizations/0 returns all authorizations" do
      authorization = authorization_fixture()
      assert Auth.list_authorizations() == [authorization]
    end

    test "get_authorization!/1 returns the authorization with given id" do
      authorization = authorization_fixture()
      assert Auth.get_authorization!(authorization.id) == authorization
    end

    test "create_authorization/1 with valid data creates a authorization" do
      assert {:ok, %Authorization{} = authorization} = Auth.create_authorization(@valid_attrs)
    end

    test "create_authorization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_authorization(@invalid_attrs)
    end

    test "update_authorization/2 with valid data updates the authorization" do
      authorization = authorization_fixture()
      assert {:ok, authorization} = Auth.update_authorization(authorization, @update_attrs)
      assert %Authorization{} = authorization
    end

    test "update_authorization/2 with invalid data returns error changeset" do
      authorization = authorization_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_authorization(authorization, @invalid_attrs)
      assert authorization == Auth.get_authorization!(authorization.id)
    end

    test "delete_authorization/1 deletes the authorization" do
      authorization = authorization_fixture()
      assert {:ok, %Authorization{}} = Auth.delete_authorization(authorization)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_authorization!(authorization.id) end
    end

    test "change_authorization/1 returns a authorization changeset" do
      authorization = authorization_fixture()
      assert %Ecto.Changeset{} = Auth.change_authorization(authorization)
    end
  end

  describe "people" do
    alias Gexbot.Auth.Person

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_person()

      person
    end

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert Auth.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Auth.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Auth.create_person(@valid_attrs)
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, person} = Auth.update_person(person, @update_attrs)
      assert %Person{} = person
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_person(person, @invalid_attrs)
      assert person == Auth.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Auth.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Auth.change_person(person)
    end
  end
end
