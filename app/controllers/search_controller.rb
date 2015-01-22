class SearchController < ApplicationController
  include ApplicationHelper

  def index
    # Parse Parameters
    # in:lines , in:books ... in:posts
    # canto:1 , book:1 , line:1  .. section:1

    # 1. Split on spaces. Left side => query , Right side => Operations
    # god awake in:lines book:1 canto:1
    # https://groups.google.com/forum/#!topic/ruby-sunspot/5xanVMY6ekQ
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
          @search = Sunspot.search Book do |context|
            context.fulltext keywords
            context.order_by(:id, :asc)
            context.facet(:category)
            context.paginate page: params[:page], per_page: @per_page = 20
          end
        when 'sentences'
          @search = Sunspot.search Stanza do |context|
            context.fulltext keywords, highlight: true
            context.order_by(:id, :asc)
            context.facet(:category)
            context.facet(:sbook)
            context.facet(:length)
            context.facet(:section)
            context.facet(:canto)
            context.with(:section).equal_to(params[:section]) if params[:section].present?
            context.with(:canto).equal_to(params[:canto]) if params[:canto].present?
            context.with(:length).equal_to(params[:length]) if params[:length].present?
            context.with(:sbook).equal_to(params[:sbook]) if params[:sbook].present?
            if params[:download]
              context.paginate page: 1, per_page: @per_page = 720
            else
              context.paginate page: params[:page], per_page: @per_page = 5
            end
          end
        when 'lines'
          @search = Sunspot.search Line do |context|
            context.fulltext keywords, highlight: true
            context.order_by(:id, :asc)
            context.facet(:category)
            context.facet(:section)
            context.facet(:canto)
            context.facet(:book)
            context.facet(:length)
            context.with(:section).equal_to(params[:section]) if params[:section].present?
            context.with(:canto).equal_to(params[:canto]) if params[:canto].present?
            context.with(:length).equal_to(params[:length]) if params[:length].present?
            context.with(:book).equal_to(params[:book]) if params[:book].present?
            if params[:download]
              context.paginate page: 1, per_page: @per_page = 24_000
            else
              context.paginate page: params[:page], per_page: @per_page = 30
            end
          end
        when 'posts'
          @search = Sunspot.search Post do |context|
            context.fulltext keywords, highlight: true
            context.with(:published_at).less_than Time.now
            context.facet(:category)
            context.facet(:posted)
            context.facet(:author)
            context.facet(:blogname)
            context.facet(:series)
            context.with(:posted).equal_to(params[:posted]) if params[:posted].present?
            context.with(:author).equal_to(params[:author]) if params[:author].present?
            context.with(:blogname).equal_to(params[:blogname]) if params[:blogname].present?
            context.with(:series).equal_to(params[:series]) if params[:series].present?
            context.paginate page: params[:page], per_page: @per_page = 5
          end
        when /[a-z]/
          @search = Sunspot.search Page do |context|
            context.fulltext keywords, highlight: true
            context.facet(:category)
            context.with(:type).equal_to(filter[1].downcase.capitalize.to_s)
            context.paginate page: params[:page], per_page: @per_page = 30
          end
        end
      end
    else
      @search  =  Sunspot.search  Line,  Book,  Stanza,  Page,  Post  do |context|
        context.fulltext params[:q], highlight: true
        context.with(:published_at).less_than Time.now
        context.facet(:category)
        if params[:category].present?
          context.with(:category).equal_to(params[:category])
        end
        context.paginate page: params[:page], per_page: @per_page = 20
      end
    end
    if params[:download]
      download
    else
      @search
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: (params[:q].present? ? @search.results : { error: 'query can\'t be blank' }) }
      end
    end
  end


  private

    def download
      query = params[:q].to_s
      query << ' book=' + params[:book].to_s if params[:book].present?
      query << ' sbook=' + params[:sbook].to_s if params[:sbook].present?
      query << ' canto=' + params[:canto].to_s if params[:canto].present?
      query << ' section=' + params[:section].to_s if params[:section].present?
      query << ' length=' + params[:length].to_s if params[:length].present?
      query.downcase!
      @file = 'Results for ['+ query + "](/search?q="+query+")\n\n---------- \n\n"
      @search.each_hit_with_result do |hit,l|
        if l.is_a?(Line)
          anchor_t = l.section.no.to_s + '.' + l.runningno.to_s
          @file << l.line + '  ||' +'['+anchor_t+']'+'(http://'+request.env["HTTP_HOST"]+l.share_url+')'+"||\n\n"
        elsif l.is_a?(Stanza)
          l.lines.each_with_index do |line, index|
           @file << line.line
           @file << "\n\n" unless index == l.lines.count - 1
         end
         anchor_t = l.section.no.to_s + "." + l.runningno.to_s
         @file << '  ||' + '['+anchor_t+']' + '(http://'+request.env["HTTP_HOST"]+share_url(l)+')' + "||\n\n"
       end
     end
     send_data @file, filename: 'results-' + query.tr('=', '_').tr(' ', '_').tr(':', '_') + '.txt', type: 'text/plain'
    end
end
