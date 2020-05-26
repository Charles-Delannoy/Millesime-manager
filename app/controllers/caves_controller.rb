class CavesController < ApplicationController

  def index
    @caves = Cave.all
  end

end

