defmodule BettingSystemWeb.SportHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use BettingSystemWeb, :html

  embed_templates "sport_html/*"
end
