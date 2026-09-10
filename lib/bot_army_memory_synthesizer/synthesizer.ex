defmodule BotArmyMemorySynthesizer.Synthesizer do
  @moduledoc """
  The core engine of the Memory Synthesizer.
  Turns raw failures (wrong_turns_raw) into distilled lessons (wrong_turns_curated).
  """
  use GenServer
  require Logger

  # Check for new raw events every minute
  @poll_interval :timer.seconds(60)

  def start_link(opts \\ []), do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  @impl true
  def init(opts) do
    Logger.info("[Synthesizer] Booting the Distillation Engine...")
    # Use a timer to trigger the synthesis loop
    schedule_next_run()
    {:ok, %{last_processed_id: 0}}
  end

  @impl true
  def handle_info(:synthesize, state) do
    Logger.info("[Synthesizer] Scanning for raw failures to distill...")

    # TODO: Implement the synthesis logic:
    # 1. Query `wrong_turns_raw` for entries with id > state.last_processed_id
    # 2. For each raw entry, send it to the LLM for distillation (pattern + lesson)
    # 3. Save the results into `wrong_turns_curated`
    # 4. Update state.last_processed_id

    schedule_next_run()
    {:noreply, state}
  end

  defp schedule_next_run do
    Process.send_after(self(), :synthesize, @poll_interval)
  end
end
