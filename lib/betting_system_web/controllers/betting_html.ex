defmodule BettingSystemWeb.BettingHTML do
  @moduledoc """
  This module contains pages rendered by PageController.
  """
  use BettingSystemWeb, :html

  embed_templates "betting/*"
end
