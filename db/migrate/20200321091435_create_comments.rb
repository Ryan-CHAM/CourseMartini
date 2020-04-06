class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :posts
      t.float :score, default: 0
      t.float :workload_score, default: 0
      t.float :teachingQuality_score, default: 0
      t.float :difficulty_score, default: 0
      t.float :usefulness_score, default: 0
      t.string :username
      t.string :courseid
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
