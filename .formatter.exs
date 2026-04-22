locals_without_parens = [
  beacon_site: 1,
  beacon_site: 2,
  beacon_sitemap_index: 1
]

dev_only_deps =
  if Mix.env() == :dev do
    [:error_tracker]
  else
    []
  end

[
  import_deps: [
    :ecto,
    :ecto_sql,
    :phoenix
  ] ++ dev_only_deps,
  line_length: 150,
  plugins: [Phoenix.LiveView.HTMLFormatter],
  migrate_eex_to_curly_interpolation: false,
  inputs: ["{mix,.formatter,dev}.exs", "{config,lib,test}/**/*.{heex,ex,exs}"],
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens]
]
