# encoding: utf-8
require 'spec_helper'

describe Line do
  let(:line) { FactoryGirl.build(:line) }

  it { expect(line).to belong_to :stanza }

  it { line.should validate_numericality_of(:no).only_integer }

  it 'creates a line with no, stanza_id and line successfully' do
    line.save!
    expect(Line.count).to eq 1
  end

  it { line.should validate_presence_of(:no) }

  it { should validate_presence_of(:stanza_id) }

  it { should validate_presence_of(:line) }

  it 'should have unique column no' do
    factory_line = FactoryGirl.create(:line)
    Line.new(no: factory_line.no, stanza_id: factory_line.stanza_id)
    should have(2).errors_on(:no)
  end

  it { Line.new.should_not allow_value('', nil).for(:stanza_id) }

  it { Line.new.should_not allow_value('', nil).for(:no) }

  it do
    FactoryGirl.create(:line)
    should validate_uniqueness_of(:no)
  end

  it 'has a valid line' do
    FactoryGirl.create(:line).should be_valid
  end

  it 'has mandatory stanza_id' do
    FactoryGirl.build(:line, stanza_id: nil).should_not be_valid
  end

  it 'has mandetory no' do
    FactoryGirl.build(:line, no: nil).should_not be_valid
  end

  it do
    FactoryGirl.create(:line)
    should validate_uniqueness_of(:no)
  end
end
