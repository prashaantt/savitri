class CompareController < ApplicationController
  def index
    @editions = Edition.all
    @books = Book.all
    @cantos = Canto.all
    @sections = Section.all
  end

  def update_books
    @books = Edition.find_by_year(params[:edition_id]).books.map{|a| [a.name, a.id]}.insert(0, "Select a Book")
  end
  def update_cantos
    @cantos = Book.find(params[:book_id]).cantos.map{|a| [a.no, a.id]}.insert(0, "Select a Canto")
  end
  def update_sections
    @sections = Canto.find(params[:canto_id]).sections.map{|a| [a.runningno, a.id]}.insert(0, "Select a Section")
  end
end
