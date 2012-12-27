#require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "book is not valid without a unique name" do
    book = Book.new(:name => books(:one).name,
      :description => "yyy",
      :no => 3)

    assert !book.save
    assert_equal "has already been taken", book.errors[:name].join('; ')
  end


  test "book is not valid without a unique no" do
    book = Book.new(:name => "new book",
      :description => "yyy - only say hello",
      :no => books(:one).no)

    assert !book.save
    assert_equal "has already been taken", book.errors[:no].join('; ')
  end


  test "book is not valid without name" do
    book = Book.new(:description => "yyy",
      :no => 4)

    assert !book.save
    assert_equal "can't be blank", book.errors[:name].join('; ')
  end


  test "book is not valid without no" do
    book = Book.new(:name => "new book",
      :description => "yyy")

    assert !book.save
    assert_equal "can't be blank", book.errors[:no].join('; ')
  end

  test "perform crud on book" do
      
      book = Book.new(:name => "new book", 
        :description =>"This is description for a good book to be saved",
        :no => 7)

      #1. create
      assert book.save, "can't be saved"
      
      #4. read
      book_new = Book.find(book.id)
      assert_equal book.name, book_new.name

      #2. update
      book.name = "Sherlok holmes"
      assert book.save, "can't update the book info"

      #3. delete
      assert book.destroy, "can't destroy"
  end
end
