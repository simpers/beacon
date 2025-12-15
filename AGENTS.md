# Agents file for Beacon

### Usage Rules

It is essential that the file [agents/USAGE.md](agents/USAGE.md) file is
consulted before any sort of reasoning or actions are taken, in order to fully
understand how to interact with any specific Elixir dependency, whether that is
through `mix` tasks or general usage of any package's API.

If any dependencies mentioned in this file are updated, the file needs to be
regenerated through `mix usage_rules.sync`, which for now will only be done by
a developer.
