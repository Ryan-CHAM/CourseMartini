class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :subject
      t.string :code
      t.text :description
      t.float :workload
      t.float :difficulty
      t.float :quality
      t.float :usefulness
      t.float :overall
      t.integer :n_comments

      t.timestamps
    end
  end
end
