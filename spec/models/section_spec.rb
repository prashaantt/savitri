require 'spec_helper'

describe Section do

  let(:section){ FactoryGirl.build(:section) }
  
  it { expect(section).to have_many :stanzas }

  it { expect(section).to belong_to :canto }

  it "creates a section with no and title successfully" do
    section.save!
    expect(Section.count).to eq 1
  end
  
  it { section.should validate_presence_of(:no) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:canto_id) }

  it { 
  	factory_section = FactoryGirl.create(:section)
    Section.new(no:factory_section.no, name:factory_section.name, canto_id:factory_section.canto_id)
    should have(1).errors_on(:no) }

  it { section = Section.new.should_not allow_value("", nil).for(:canto_id) }

  it {  FactoryGirl.create(:canto)
    should validate_uniqueness_of(:no).scoped_to(:canto_id) }
end
