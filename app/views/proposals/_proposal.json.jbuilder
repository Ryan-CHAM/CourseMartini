# course json: automatically generated by the Rails Framework
# PURPOSE: define the communication protocool for the database operations related to proposal


json.extract! proposal, :id, :name, :code, :subject, :faculty, :instructor, :description, :book, :url, :created_at, :updated_at, :status
json.url proposal_url(proposal, format: :json)
