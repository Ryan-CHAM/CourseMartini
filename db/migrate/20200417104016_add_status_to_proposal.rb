class AddStatusToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :status, :string, default: 'pending'
  end
end
