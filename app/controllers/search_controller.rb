class SearchController < ApplicationController
  include ApplicationHelper

  def index
    # Parse Parameters
    # in:lines , in:books ... in:posts
    # canto:1 , book:1 , line:1  .. section:1

    # 1. Split on spaces. Left side => query , Right side => Operations
    # god awake in:lines book:1 canto:1
    if params[:q].to_s.include?('in:')
      pams = params[:q].split('in:')
      query = params[:q].downcase.split(/\s+/)
      @condition = query[query.index {|v| v.start_with? "in:" }]
      filter = @condition.split("in:")
      keywords = params[:q].strip.dup
      keywords.slice! @condition
      keywords.strip
      unless pams.length > 2
        case filter[1]
        when 'books'
          @search = Sunspot.search Book do
            fulltext keywords
            order_by(:id, :asc)
            facet(:category)
            paginate page: params[:page], per_page:  20
          end
        when 'sentences'
          @search = Sunspot.search Stanza do
            fulltext keywords, highlight: true
            order_by(:id, :asc)
            facet(:category)
            facet(:sbook)
            facet(:length)
            facet(:section)
            facet(:canto)
            with(:section).equal_to(params[:section]) if params[:section].present?
            with(:canto).equal_to(params[:canto]) if params[:canto].present?
            with(:length).equal_to(params[:length]) if params[:length].present?
            with(:sbook).equal_to(params[:sbook]) if params[:sbook].present?
            if params[:download]
              paginate page: 1, per_page: 720
            else
              paginate page: params[:page], per_page: 5
            end
          end
        when 'lines'
          @search = Sunspot.search Line do
            fulltext keywords, highlight: true
            order_by(:id, :asc)
            facet(:category)
            facet(:section)
            facet(:canto)
            facet(:lbook)
            facet(:length)
            with(:section).equal_to(params[:section]) if params[:section].present?
            with(:canto).equal_to(params[:canto]) if params[:canto].present?
            with(:length).equal_to(params[:length]) if params[:length].present?
            with(:lbook).equal_to(params[:lbook]) if params[:lbook].present?
            if params[:download]
              paginate page: 1, per_page: 24_000
            else
              paginate page: params[:page], per_page: 30
            end
          end
        when 'posts'
          @search = Sunspot.search Post do
            fulltext keywords, highlight: true
            with(:published_at).less_than Time.now
            facet(:category)
            facet(:posted)
            facet(:author)
            facet(:blogname)
            facet(:series)
            with(:posted).equal_to(params[:posted]) if params[:posted].present?
            with(:author).equal_to(params[:author]) if params[:author].present?
            with(:blogname).equal_to(params[:blogname]) if params[:blogname].present?
            with(:series).equal_to(params[:series]) if params[:series].present?
            paginate page: params[:page], per_page: 5
          end
        when /[a-z]/
          @search = Sunspot.search Page do
            fulltext keywords, highlight: true
            facet(:category)
            with(:type).equal_to(filter[1].downcase.capitalize.to_s)
            paginate page: params[:page], per_page: 30
          end
        end
      end
    else
      @search  =  Sunspot.search  Line,  Book,  Stanza,  Page,  Post  do
         fulltext params[:q], highlight: true
         with(:published_at).less_than Time.now
         facet(:category)
         if params[:category].present?
           with(:category).equal_to(params[:category])
         end
         paginate page: params[:page], per_page: 20
         end
    end
    if params[:download]
      download
    else
      @search
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @lines }
      end
    end
  end


  private

    def download
      query = params[:q].to_s
      query << ' lbook=' + params[:lbook].to_s if params[:lbook].present?
      query << ' sbook=' + params[:sbook].to_s if params[:sbook].present?
      query << ' canto=' + params[:canto].to_s if params[:canto].present?
      query << ' section=' + params[:section].to_s if params[:section].present?
      query << ' length=' + params[:length].to_s if params[:length].present?
      query.downcase!
      @file = 'Results for ['+ query + "](/search?q="+query+")\n\n---------- \n\n"
      @search.each_hit_with_result do |hit,l|
        if l.is_a?(Line)
          anchor_t = l.section.to_s + '.' + l.runningno.to_s
          @file << l.line + '  ||' +'['+anchor_t+']'+'('+l.share_url+')'+'||\n\n'
        elsif l.is_a?(Stanza) 
          l.lines.each_with_index do |line, index|
           @file << line.line
           @file << '\n\n' unless index == l.lines.count - 1
         end
         anchor_t = l.section.to_s + "." + l.runningno.to_s
         @file << '  ||' + '['+anchor_t+']' + '('+share_url(l.no)+')' + '||\n\n'
       end
     end
     send_data @file, filename: 'results-' + query.tr('=', '_').tr(' ', '_').tr(':', '_') + '.txt', type: 'text/plain'
    end
end
