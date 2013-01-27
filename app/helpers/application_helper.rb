module ApplicationHelper
	def is_active(controller)
			(params[:controller] == controller) ? "active" : nil 
  	end
end
