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
