defmodule SequenceSupervisor do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    SequenceSupervisor.Supervisor.start_link(Application.get_env(:sequence_supervisor, :initial_number))
  end
end
