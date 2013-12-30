# encoding: utf-8
require 'spec_helper'

describe Canto do
  let(:canto) { FactoryGirl.build(:canto) }

  it { expect(canto).to have_many :sections }

  it { should have_many(:stanzas).through(:sections) }

  it { expect(canto).to belong_to :book }

  it 'creates a canto with no and title and book_id successfully' do
    canto.save!
    expect(Canto.count).to eq 1
  end

  it do
    FactoryGirl.create(:canto)
    should validate_uniqueness_of(:no).scoped_to(:book_id)
  end

  it do
    factory_canto = FactoryGirl.create(:canto)
    Canto.new(title: factory_canto.title, no: factory_canto.no)
    should validate_uniqueness_of(:title)
  end

  it { should validate_presence_of(:title) }

  it { should validate_uniqueness_of(:no) }

  it { should validate_presence_of(:no) }

  # it { should validate_numericality_of(:no).only_integer }

  # it 'fails validation with title as integer' do
  #   Canto.new(title:1).should have(1).error_on(:title)
  # end

  it 'fails validation with no number' do
    Canto.new.should have(1).errors_on(:no)
  end

  it { Canto.new.should_not allow_value('', nil).for(:title) }

  it 'passes validation with a title' do
    Canto.new(title: 'liquid nitrogen').should have(0).errors_on(:title)
  end

  it 'passes validation with no description' do
    Canto.new.should have(0).errors_on(:description)
  end

  it 'has a valid canto' do
    FactoryGirl.create(:canto).should be_valid
  end

  it 'has mandatory title' do
    FactoryGirl.build(:canto, title: nil).should_not be_valid
  end

  it 'has mandetory no' do
    FactoryGirl.build(:canto, no: nil).should_not be_valid
  end

  it 'should have many sections' do
    canto = Canto.reflect_on_association(:sections)
    canto.macro.should == :has_many
  end

  it 'should belong to books' do
    canto = Canto.reflect_on_association(:book)
    canto.macro.should == :belongs_to
  end

  it do
    Canto.new(no: 1, title: 1).should_not allow_value('', nil).for(:book_id)
  end
end
