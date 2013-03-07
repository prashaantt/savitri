class SearchController < ApplicationController

  def index
    # Parse Parameters
    # in:lines , in:books ... in:posts
    # canto:1 , book:1 , line:1  .. section:1

    #1. Split on spaces. Left side => query , Right side => Operations
    # god awake in:lines book:1 canto:1
    if params[:q].to_s.include?("in:")
      query = params[:q].split("in:")
        case query[1].downcase
          when "books"
            @search = Sunspot.search Book do
              fulltext query[0]
              order_by(:id, :asc)
              facet(:book)
              facet(:canto)
              facet(:section)
              with(:book).equal_to(params[:book]) if params[:book].present?
              with(:canto).equal_to(params[:canto]) if params[:canto].present?
              with(:section).equal_to(params[:section]) if params[:section].present?              
              paginate :page => params[:page], :per_page => 20
            end
          when "sentences"
            @search = Sunspot.search Stanza do
              fulltext query[0]
              order_by(:id, :asc)
              facet(:sbook)
              facet(:length)
              facet(:section)
              facet(:canto)
              with(:section).equal_to(params[:section]) if params[:section].present?
              with(:canto).equal_to(params[:canto]) if params[:canto].present?
              with(:length).equal_to(params[:length]) if params[:length].present?
              with(:sbook).equal_to(params[:sbook]) if params[:sbook].present?
              paginate :page => params[:page], :per_page => 5
            end
          when "lines"
            @search = Sunspot.search Line do
              fulltext query[0]
              order_by(:id, :asc)
              facet(:section)
              facet(:canto)
              facet(:lbook)
              facet(:length)
              with(:section).equal_to(params[:section]) if params[:section].present?
              with(:canto).equal_to(params[:canto]) if params[:canto].present?
              with(:length).equal_to(params[:length]) if params[:length].present?
              with(:lbook).equal_to(params[:lbook]) if params[:lbook].present?
              paginate :page => params[:page], :per_page => 30
          end
        end
    else
       @search = Sunspot.search Line, Book, Stanza do
        fulltext params[:q]
        facet(:category)
         if params[:category].present?
           with(:category).equal_to(params[:category])
         end
        paginate :page => params[:page], :per_page => 20
      end
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
