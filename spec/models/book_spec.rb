# encoding: utf-8
require 'spec_helper'

describe Book do

  let(:book) { Book.new(name: 'book_1', no: 1) }

  it { expect(book).to have_many :cantos }

  it { should have_many(:sections).through(:cantos) }

  it { should have_many(:stanzas).through(:cantos) }

  it { should have_many(:lines).through(:stanzas) }

  it { book.should validate_numericality_of(:no).only_integer }

  it 'creates a book with no and name successfully' do
    book.save!
  end

  it 'increments book count by 1 after creating book successfully' do
    book.save!
    expect(Book.count).to eq 1
  end

  it do
    factory_book = FactoryGirl.create(:book)
    Book.new(name: factory_book.name, no: factory_book.no)
    should validate_uniqueness_of(:name)
  end
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:no) }

  it { should validate_presence_of(:no) }

  # it { should validate_numericality_of(:no).only_integer }

  it 'fails validation with no name' do
    Book.new.should have(1).error_on(:name)
  end

  it 'fails validation with no number' do
    Book.new.should have(2).errors_on(:no)
  end

  it 'passes validation with a name' do
    Book.new(name: 'harry potter').should have(0).errors_on(:name)
  end

  it 'passes validation with no description' do
    Book.new.should have(0).errors_on(:description)
  end

  it 'has a valid book' do
    FactoryGirl.create(:book).should be_valid
  end

  it 'has mandatory name' do
    FactoryGirl.build(:book, name: nil).should_not be_valid
  end

  it 'has mandatory no' do
    FactoryGirl.build(:book, no: nil).should_not be_valid
  end

  it { should allow_value('', nil).for(:description) }
end
