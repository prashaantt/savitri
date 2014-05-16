class ErrorsController < ApplicationController

  def show
    @exception = env["action_dispatch.exception"]
    respond_to do |format|
      format.html { render action: request.path[1..-1], status: request.path[1..-1] }
      format.json { render json: {status: request.path[1..-1], error: @exception.message} }
      format.atom { render layout: false, content_type: 'application/xml', action: 'atom' }
    end
  end
end
