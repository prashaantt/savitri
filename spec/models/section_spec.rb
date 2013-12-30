# encoding: utf-8
require 'spec_helper'

describe Section do

  let(:section) { FactoryGirl.build(:section) }

  it { expect(section).to have_many :stanzas }

  it { should have_many(:lines).through(:stanzas) }

  it { expect(section).to belong_to :canto }

  it 'creates a section with no, name and canto_id successfully' do
    section.save!
    expect(Section.count).to eq 1
  end

  it { section.should validate_presence_of(:no) }

  it { should validate_presence_of(:name) }
  
  it { should validate_presence_of(:canto_id) }

  it do
    factory_section = FactoryGirl.create(:section)
    Section.new(no: factory_section.no, name: factory_section.name,
                canto_id: factory_section.canto_id)
    should have(1).errors_on(:no)
  end

  it { Section.new.should_not allow_value('', nil).for(:canto_id) }

  it do
    FactoryGirl.create(:section)
    should validate_uniqueness_of(:no).scoped_to(:canto_id)
  end

  it 'fails validation with no number' do
    Section.new.should have(1).errors_on(:no)
  end

  it { Section.new.should_not allow_value('', nil).for(:name) }

  it 'passes validation with a name' do
    Section.new(name: 'liquid nitrogen').should have(0).errors_on(:name)
  end

  it 'passes validation with no description' do
    Section.new.should have(0).errors_on(:description)
  end

  it 'has a valid section' do
    FactoryGirl.create(:section).should be_valid
  end

  it 'has mandatory name' do
    FactoryGirl.build(:section, name: nil).should_not be_valid
  end

  it 'has mandetory no' do
    FactoryGirl.build(:section, no: nil).should_not be_valid
  end

  it 'should have many sections' do
    section = Section.reflect_on_association(:stanzas)
    section.macro.should == :has_many
  end

  it 'should belong to canto' do
    section = Section.reflect_on_association(:canto)
    section.macro.should == :belongs_to
  end

  it do
    Section.new(no: 1, name: 1).should_not allow_value('', nil).for(:canto_id)
  end  
end
