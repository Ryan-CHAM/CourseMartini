class User < ApplicationRecord
	has_many :comments
	has_many :courses, through: :comments
end
