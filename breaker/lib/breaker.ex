defmodule Breaker do
  use GenServer

  alias Breaker.Game

  def move(game \\ __MODULE__, move) do
    GenServer.call(game, {:move, move}) |> IO.puts
  end

  def start_link(answer \\ nil) do
    GenServer.start_link(__MODULE__, answer, name: __MODULE__)
  end

  @impl true
  def init(answer) do
    {:ok, Game.new(answer)}
  end

  @impl true
  def handle_call({:move, move}, _from, game) do
    game = Game.move(game, move)
    {:reply, Game.humanize(game), game}
  end
end
