# run this with elixir

# doc http://erlang.org/doc/design_principles/gen_server_concepts.html
defmodule TaskList do
  use GenServer
 
  # Client API
 
  def start_link(options \\ [] ) do
    GenServer.start_link(__MODULE__, :ok, options)
  end

  @doc """
  Looks up the item pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the item exists, `:error` otherwise.
  """ 
  def read(pid) do
    GenServer.call(pid, {:read})
  end
 
  def add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end
 
  # Server Callbacks
 
  def init(:ok) do
    {:ok, []}
  end
 
  def handle_call({:read}, _from, list) do
    {:reply, list, list}
  end
 
  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end
end

# Start the server
{:ok, pid} = TaskList.start_link

# Start a 2nd server
{:ok, pid2} = TaskList.start_link

#  # Adding some items to server 1
IO.inspect TaskList.add(pid, "fetch")
IO.inspect TaskList.add(pid, "fetch")
IO.inspect TaskList.add(pid, "execute")
IO.inspect TaskList.add(pid, "post")

#  # Adding some items to server 2
IO.inspect TaskList.add(pid2, "fetch2")
IO.inspect TaskList.add(pid2, "second")
IO.inspect TaskList.add(pid2, "parallel")
#   # Read the items back
IO.puts 'Printing list results'
IO.inspect TaskList.read(pid)

#   # Read the items back
IO.puts 'Printing list results for 2ndserver'
IO.inspect TaskList.read(pid2)

