class LineSweeper < ActionController::Caching::Sweeper

  observe Line

  def after_save(line)
    host = Rails.env.production? ? 'savitri.in' : 'localhost:3000'
    Rails.cache.delete("views/#{host}/read/#{line.book.no}/#{line.canto.no}/#{line.section.no}")
    Rails.cache.delete("views/#{host}/read/#{line.book.no}/#{line.canto.no}/#{line.section.no}?edition=#{line.book.edition.year}")
  end
end
