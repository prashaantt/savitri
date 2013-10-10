class SearchController < ApplicationController
  include ApplicationHelper

  def index
    # Parse Parameters
    # in:lines , in:books ... in:posts
    # canto:1 , book:1 , line:1  .. section:1

    #1. Split on spaces. Left side => query , Right side => Operations
    # god awake in:lines book:1 canto:1
    if params[:q].to_s.include?("in:")
      query = params[:q].split("in:")
      unless query.length > 2
        case query[1].downcase
          when "books"
            @search = Sunspot.search Book do
              fulltext query[0]
              order_by(:id, :asc)
              paginate :page => params[:page], :per_page => 20
            end
          when "sentences"
            @search = Sunspot.search Stanza do
              fulltext query[0], :highlight => true
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
              fulltext query[0], :highlight => true
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
          when "posts"
            @search = Sunspot.search Post do
              fulltext query[0], :highlight => true
              facet(:posted)
              facet(:author)
              facet(:blogname)
              with(:posted).equal_to(params[:posted]) if params[:posted].present?
              with(:author).equal_to(params[:author]) if params[:author].present?
              with(:blogname).equal_to(params[:blogname]) if params[:blogname].present?
              paginate :page => params[:page], :per_page => 5
            end
        end
      end
    else
       @search = Sunspot.search Line, Book, Stanza, Post do
        fulltext params[:q], :highlight => true
        facet(:category)
         if params[:category].present?
           with(:category).equal_to(params[:category])
         end
        paginate :page => params[:page], :per_page => 20
      end
    end

    @search
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def download
    # Parse Parameters
    # in:lines , in:books ... in:posts
    # canto:1 , book:1 , line:1  .. section:1

    #1. Split on spaces. Left side => query , Right side => Operations
    # god awake in:lines book:1 canto:1
    if params[:q].to_s.include?("in:")
      query = params[:q].split("in:")
      unless query.length > 2
        case query[1].downcase
          when "sentences"
            @search = Sunspot.search Stanza do
              fulltext query[0], :highlight => true
              order_by(:id, :asc)
              facet(:sbook)
              facet(:length)
              facet(:section)
              facet(:canto)
              with(:section).equal_to(params[:section]) if params[:section].present?
              with(:canto).equal_to(params[:canto]) if params[:canto].present?
              with(:length).equal_to(params[:length]) if params[:length].present?
              with(:sbook).equal_to(params[:sbook]) if params[:sbook].present?
            end
          when "lines"
            @search = Sunspot.search Line do
              fulltext query[0], :highlight => true
              order_by(:id, :asc)
              facet(:section)
              facet(:canto)
              facet(:lbook)
              facet(:length)
              with(:section).equal_to(params[:section]) if params[:section].present?
              with(:canto).equal_to(params[:canto]) if params[:canto].present?
              with(:length).equal_to(params[:length]) if params[:length].present?
              with(:lbook).equal_to(params[:lbook]) if params[:lbook].present?
          end
        end
      end
    else
       @search = Sunspot.search Line, Stanza do
        fulltext params[:q], :highlight => true
        facet(:category)
         if params[:category].present?
           with(:category).equal_to(params[:category])
         end
      end
    end
    query = params[:q].to_s
    query << " lbook="+params[:lbook].to_s if params[:lbook].present?
    query << " sbook=" + params[:sbook].to_s if params[:sbook].present? 
    query << " canto=" + params[:canto].to_s if params[:canto].present?
    query << " section=" + params[:section].to_s if params[:section].present?
    query << " length=" + params[:length].to_s if params[:length].present?
    query.downcase!
    @file = 'Results for ['+ query + "](/search?q="+query+")\n\n---------- \n\n"
    @search.each_hit_with_result do |hit,l|
      if l.is_a?(Line)
        anchor_t = l.section.to_s + "." + l.runningno.to_s
        @file << l.line + "  ||" +"["+anchor_t+"]"+"("+l.share_url+")"+"||\n\n"
      elsif l.is_a?(Stanza) 
        l.lines.each_with_index do |line, index|
          @file << line.line
          unless index == l.lines.count - 1
             @file << "\n\n"
          end
        end
        anchor_t = l.section.to_s + "." + l.runningno.to_s
        @file << "  ||" +"["+anchor_t+"]"+"("+share_url(l.no)+")"+"||\n\n"
      end
    end
    send_data @file, :filename => 'results-'+ query.tr("=","_").tr(" ","_").tr(":","_") + '.txt', :type => 'text/plain'
    
  end
end
