defmodule Kite.Instruments do
  @moduledoc """
  The Instruments context.
  """

  import Ecto.Query, warn: false
  alias Kite.Repo

  alias Kite.Instruments.NSE

  @doc """
  Returns the list of nse.

  ## Examples

      iex> list_nse()
      [%NSE{}, ...]

  """
  def list_nse do
    Repo.all(NSE)
  end

  @doc """
  Gets a single nse.

  Raises `Ecto.NoResultsError` if the Nse does not exist.

  ## Examples

      iex> get_nse!(123)
      %NSE{}

      iex> get_nse!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nse!(id), do: Repo.get!(NSE, id)

  @doc """
  Creates a nse.

  ## Examples

      iex> create_nse(%{field: value})
      {:ok, %NSE{}}

      iex> create_nse(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nse_instruments(attrs \\ %{}) do
    %NSE{}
    |> NSE.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nse.

  ## Examples

      iex> update_nse(nse, %{field: new_value})
      {:ok, %NSE{}}

      iex> update_nse(nse, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nse(%NSE{} = nse, attrs) do
    nse
    |> NSE.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nse.

  ## Examples

      iex> delete_nse(nse)
      {:ok, %NSE{}}

      iex> delete_nse(nse)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nse(%NSE{} = nse) do
    Repo.delete(nse)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nse changes.

  ## Examples

      iex> change_nse(nse)
      %Ecto.Changeset{data: %NSE{}}

  """
  def change_nse(%NSE{} = nse, attrs \\ %{}) do
    NSE.changeset(nse, attrs)
  end
end
