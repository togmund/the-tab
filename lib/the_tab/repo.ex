defmodule TheTab.Repo do
  use Ecto.Repo,
    otp_app: :the_tab,
    adapter: Ecto.Adapters.Postgres
end
