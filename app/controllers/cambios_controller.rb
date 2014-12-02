class CambiosController < ApplicationController

  def index
    @cambios = Cambio.limit(params[:limit]).offset(params[:offset])
    render json: @cambios.to_json
  end

  #Cambio en pesos
  def show
    render json: Cambio.currency(params[:money])
  end

end
