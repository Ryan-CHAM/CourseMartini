=begin
set default values for the rating fields in course
PROGRAMMER:   Zhou Jinan
VERSION:      last update 2020-4-10
PURPOSE:      set default values for the rating fields in course
REMARK:       all the scores are set to 0 by default, and they are set
              upon creation. Therefore, the edit form of courses does not
              contain the those socres.
=end


class AddDefaultToCourses < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :workload, :float, :default => 0
    change_column :courses, :difficulty, :float, :default => 0
    change_column :courses, :quality, :float, :default => 0
    change_column :courses, :usefulness, :float, :default => 0
    change_column :courses, :overall, :float, :default => 0
    change_column :courses, :gpa, :float, :default => 0
    change_column :courses, :n_comments, :integer, :default => 0
  end
end
