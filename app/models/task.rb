class Task < ActiveRecord::Base
  attr_accessible :desc, :proposedby, :pdate, :edate, :person, :sdate, :task
end
