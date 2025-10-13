defmodule Beacon.Content.Snippets.TagHelper do
  @moduledoc false

  @behaviour Solid.Tag

  alias Solid.Argument
  alias Solid.Parser

  @enforce_keys [:argument, :loc]
  defstruct [:argument, :loc]

  @impl Solid.Tag
  def parse("helper", loc, context) do
    with {:ok, tokens, context} <- Solid.Lexer.tokenize_tag_end(context),
         {:ok, argument, [{:end, _}]} <- Argument.parse(tokens) do
      {:ok, %__MODULE__{argument: argument, loc: loc}, context}
    else
      {:ok, _argument, rest} -> {:error, "Unexpected token", Parser.meta_head(rest)}
      {:error, reason, _rest, loc} -> {:error, reason, loc}
      error -> error
    end
  end

  defimpl Solid.Renderable do
    alias Beacon.Content.Snippets.TagHelper

    def render(%TagHelper{argument: %_{value: helper_name}}, context = %{counter_vars: %{"page" => %{"site" => site}}}, _opts) do
      site = Beacon.Types.Atom.safe_to_atom(site)
      helper_name = String.to_atom(helper_name)

      text =
        site
        |> Beacon.apply_mfa(Beacon.Loader.fetch_snippets_module(site), helper_name, [context.counter_vars])
        |> to_string()

      {text, context}
    end
  end
end
