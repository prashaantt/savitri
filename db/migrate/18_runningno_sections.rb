class RunningnoSections < ActiveRecord::Migration
  def change
   add_column :sections, :runningno, :integer
   Canto.all.each do |c|
      count=1
      c.sections.each do |s|
		s.runningno=count
		count=count+1
		s.save
     end
   end

  end

  def self.down
    remove_column :runningno
  end
end
