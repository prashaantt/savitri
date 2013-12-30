# encoding: utf-8
require 'spec_helper'

describe Stanza do
  let(:stanza) { FactoryGirl.build(:stanza) }

  it { expect(stanza).to have_many :lines }

  it { expect(stanza).to belong_to :section }

  it { stanza.should validate_numericality_of(:no).only_integer }

  it 'creates a stanza with no and section_id successfully' do
    stanza.save!
    expect(Stanza.count).to eq 1
  end

  it { stanza.should validate_presence_of(:no) }

  it { should validate_presence_of(:section_id) }

  it do
    factory_stanza = FactoryGirl.create(:stanza)
    Stanza.new(no: factory_stanza.no, section_id: factory_stanza.section_id)
    should have(2).errors_on(:no)
  end

  it { Stanza.new.should_not allow_value('', nil).for(:section_id) }

  it do
    FactoryGirl.create(:stanza)
    should validate_uniqueness_of(:no)
  end

  it 'fails validation with no number' do
    Stanza.new.should have(2).errors_on(:no)
  end

  it 'has a valid stanza' do
    FactoryGirl.create(:stanza).should be_valid
  end

  it 'has mandatory section_id' do
    FactoryGirl.build(:stanza, section_id: nil).should_not be_valid
  end

  it 'has mandetory no' do
    FactoryGirl.build(:stanza, no: nil).should_not be_valid
  end
end
