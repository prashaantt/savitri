#require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

class LineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "line is not valid without a unique no" do
    line = Line.new(:no => 1,
      :line => "yyy - only say hello",
      :stanza_id => 1)

    assert !line.save
    assert_equal "has already been taken", line.errors[:no].join('; ')
  end


  test "line is not valid without stanza_id" do
    line = Line.new(:line => "yyy",
      :no => 4)

    assert !line.save
    assert_equal "can't be blank", line.errors[:stanza_id].join('; ')

  end

  test "line is not valid without line" do
    line = Line.new(:no => 4,
      :stanza_id => 1)
    assert !line.save
    assert_equal "can't be blank", line.errors[:line].join('; ')
  end

  test "line is not valid without no" do
    line = Line.new(:line => "yyy",
      :stanza_id => 1)
    assert !line.save
    assert_equal "can't be blank", line.errors[:no].join('; ')
  end


  test "perform crud on line" do
      
      line = Line.new(:line =>"This is line for a good line to be saved",
        :no => 7,
        :stanza_id=>2)

      #1. create
      assert line.save, "can't be saved"
      
      #4. read
      line_new = Line.find(line.id)
      assert_equal line.line, line_new.line

      #2. update
      line.line = "Sherlok holmes"
      assert line.save, "can't update the line info"

      #3. delete
      assert line.destroy, "can't destroy"
  end
end
