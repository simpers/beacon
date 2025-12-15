import Config

config :beacon, :generators, binary_id: true

config :error_tracker, repo: Beacon.BeaconTest.Repo, otp_app: :beacon, enabled: true

config :phoenix, :json_library, Jason

config :tailwind,
  version: "4.1.18",
  beacon: [
    args: ~w(
      --output=../priv/static/beacon.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

import_config("#{config_env()}.exs")
