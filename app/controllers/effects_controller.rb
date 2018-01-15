class EffectsController < ApplicationController
  def show
    @effect = Effect.find(params[:id])
  end
end
