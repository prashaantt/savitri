module ReadHelper
  def edition_wise_stanza_url
    if params[:edition].present?
      "?edition=#{params[:edition]}"
    else
      nil
    end
  end
end
