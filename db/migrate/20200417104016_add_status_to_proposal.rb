=begin
add status to proposal
PROGRAMMER:   Zhou Jinan
VERSION:      last update 2020-4-15
PURPOSE:      add the status column to proposal
=end


class AddStatusToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :status, :string, default: 'pending'
  end
end
