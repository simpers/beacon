import Config

config :beacon, :generators, binary_id: true

config :phoenix, :json_library, Jason

if Mix.env() == :dev do
  esbuild = fn args ->
    [
      args: ~w(./js/beacon.js --bundle --format=iife --target=es2016 --global-name=Beacon) ++ args,
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.25.10",
    cdn: esbuild.(~w(--outfile=../priv/static/beacon.js)),
    cdn_min: esbuild.(~w(--minify --outfile=../priv/static/beacon.min.js))
end

config :tailwind,
  version: "4.1.14",
  beacon: [
    args: ~w(
      --output=../priv/static/beacon.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# keep do block for igniter
if config_env() == :test do
  import_config("test.exs")
end
