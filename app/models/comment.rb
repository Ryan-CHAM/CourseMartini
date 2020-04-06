class Comment < ApplicationRecord
	belongs_to :user, validate: true
	belongs_to :course, validate: true
end
