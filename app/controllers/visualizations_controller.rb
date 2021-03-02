class VisualizationsController < ApplicationController
  def index
    @data = [
      EventsFetcher.new.activities,
      # EventsFetcher.new.series
    ]
  end
end
