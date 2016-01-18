class BaseController < ApplicationController
  def index
    @levels = Game.all
  end
end
