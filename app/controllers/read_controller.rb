class ReadController < ApplicationController
  def index
  	#@cantos = Canto.includes("stanzas").includes("lines").order("cantono").page(params[:cantos]).per(1)
  	#@lines = Line.order("no").page(params[:cantos]).per(5)
  	@stanzas = Stanza.includes("lines").order("stanzno").page(params[:stanzas]).per(4)

  	respond_to do |format|
      format.html # index.html.erb
      format.js 
      format.json { render json: @stanzas }
    end
  end

  def show
    
    @canto =  Canto.find(params[:id])
    @stanzas = @canto.stanzas.includes("lines").order("stanzno").page(params[:stanzas]).per(4)
    #@stanzas = Stanza.find(:conditions => { :canto_id => @canto.id}) 
#    @stanzas = Stanza.includes("lines").order("stanzno").page(params[:stanzas]).per(4)
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @stanzas }
    end
  end
end
