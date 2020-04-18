json.extract! proposal, :id, :name, :code, :subject, :faculty, :instructor, :description, :book, :url, :created_at, :updated_at, :status
json.url proposal_url(proposal, format: :json)
