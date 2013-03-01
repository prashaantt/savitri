class SearchController < ApplicationController

  def index
    #puts params.inspect
    #@search = Line.search(params[:q])
    #@lines = @search.result
    @search = Line.search do
      fulltext params[:q]
      order_by(:id, :asc)
      facet(:canto)
      facet(:length)
      if params[:canto].present?
        with(:canto).equal_to(params[:canto])
      end
      if params[:length].present?
        with(:length).equal_to(params[:length])
      end
      #with(:canto, params[:canto]) if params[:canto].present?
      paginate :page => params[:page], :per_page => 20
    end
    @search
    puts @search.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def results
    @search = Line.search do
      fulltext params[:q]
      order_by(:id, :asc)
      paginate :page => params[:page], :per_page => 20
    end
    @results = @search.results
=begin
    parameters = infixco (params[:q])
    puts "----------"
    puts  parameters
    query_string = ""
    parameters.each do |token|
      case token
      when 'and', 'or', 'and not'
        query_string << " #{token} "
      else
        query_string << " line like '#{token}' "
      end
    end
    puts query_string
    @results = Line.all(:conditions=>"#{query_string}")
    @results =Line.search("@{params[:q]}")
=end

    #puts (topostfix infixco(params[:q]))
    # it was and

    #query = params[:q].split(" ")
    #query_string=""
    #if query.count > 1
    #  (query.count-1).times do |q|
    #    query_string << "line LIKE '%#{query[q]}%'"
    #  end
    #  query_string << " AND line LIKE '%#{query[query.count-1]}%'"
    #  puts query_string
    #else
    #  query_string << "line LIKE '%#{params[:q]}%'"
    #end
    #unless 
    #  @results = Line.all(:conditions=>"#{query_string}")
    #end
  end

  private
  def infixco questions
  infix = Array.new
      tokens = questions.split(" ")
      tokens.count.times do |cnt|
  unless tokens[cnt] == 'and' || tokens[cnt] == 'or' || tokens[cnt] == 'not'
    if cnt == tokens.count-1
      infix<< tokens[cnt]
    else
      if tokens[cnt+1] == 'and' || tokens[cnt+1] == 'or'
        infix<< tokens[cnt] 
        infix<<tokens[cnt+1]
      else
        if tokens [cnt+1] == 'not'
          infix << tokens[cnt]
          infix << 'and ' + tokens[cnt+1]
        else
          infix<< tokens[cnt]
          infix<<'and'
        end
      end
    end
  end
end
    infix
  end


def topostfix infix
  postfix = Array.new
  stack = Array.new
  infix.each do |token|
     case token
     when 'and', 'or', 'AND', 'OR'
        if stack.empty? == true
          stack.push(token)   
        else
            loop {  
              if (stack.empty? == false && precedence[token]<=precedence[stack.last])
                postfix.push(stack.pop)
              else
                stack.push(token)
                break
              end
             }
        end
        else
            postfix.push(token)
        end
    end
    if stack.empty? == false
      postfix.push(stack.pop)
    end
    postfix  
  end

end
