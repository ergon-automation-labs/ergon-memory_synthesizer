defmodule BotArmyMemorySynthesizer.Repo do
  use Ecto.Repo,
    otp_app: :bot_army_memory_synthesizer,
    adapter: Ecto.Adapters.Postgres
end
