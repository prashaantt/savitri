class SavitriController < ApplicationController
  
  def index

  end

  def show
  	 @sentence = Stanza.order("RANDOM()").last;
  	 #@text = @sentence.lines.to_json(:only => :line)
  	 @text = Array.new
  	 @sentence.lines.each do |l|
  	 	@text << l.line
  	 end
# 	 format.json {render :json => @section.to_json(:include => :lines)}

  	 respond_to do |format|
      format.html # show.html.erb
      format.json {render :json => {:text => @text, :source => Section.find(@sentence.section).no.to_s + "." + @sentence.runningno.to_s }}
    end
  end
end


# text4 = "{ \"text\": 
#			[\"There is a deeper seeing from within\",
#			 \"And, when we have left these small purlieus of mind,\",
# 			 \"A greater vision meets us on the heights\",
# 			 \"In the luminous wideness of the Spirit’s gaze.\"
#			], 
#			\"source\": \"47.3\" }"