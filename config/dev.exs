import Config

esbuild = fn args ->
  [
    args: ~w(./js/beacon.js --bundle --format=iife --target=es2016 --global-name=Beacon) ++ args,
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
end

config :beacon,
  dev_routes: true

config :esbuild,
  version: "0.27.1",
  cdn: esbuild.(~w(--outfile=../priv/static/beacon.js)),
  cdn_min: esbuild.(~w(--minify --outfile=../priv/static/beacon.min.js))
