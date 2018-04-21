{:ok, _} = Application.ensure_all_started(:hound)

ExUnit.start(exclude: [:ui])

Ecto.Adapters.SQL.Sandbox.mode(Prater.Repo, :manual)

