class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :code
      t.string :subject
      t.string :faculty
      t.string :instructor
      t.text :description
      t.text :book
      t.text :url

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
