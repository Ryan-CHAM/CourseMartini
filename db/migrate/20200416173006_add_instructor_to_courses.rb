=begin
add instructor to course
PROGRAMMER:   Zhou Jinan
VERSION:      last update 2020-4-10
PURPOSE:      add the instructor column to course
=end


class AddInstructorToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :instructor, :string
  end
end
