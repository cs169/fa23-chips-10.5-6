# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representatives = Representative.find(params[:id])
  end
end
