class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      # basic information of the course
      t.string :name
      t.string :code
      t.string :subject
      t.string :faculty
      t.text :description

      # reviews of the course
      t.float :workload
      t.float :difficulty
      t.float :quality
      t.float :usefulness
      t.float :overall
      t.float :gpa     
      t.integer :n_comments

      # course resources
      t.text :book
      t.text :url

      t.timestamps
    end
  end
end
