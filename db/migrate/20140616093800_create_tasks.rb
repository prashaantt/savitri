class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.string :proposedby
      t.text :desc
      t.date :sdate # task start date
      t.date :edate # task end date
      t.date :pdate # task proposed date
      t.string :person

      t.timestamps
    end
  end
end
