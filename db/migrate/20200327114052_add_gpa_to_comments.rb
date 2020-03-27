class AddGpaToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :gpa, :float
  end
end
