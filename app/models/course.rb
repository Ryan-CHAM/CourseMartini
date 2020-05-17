=begin
COURSE MODEL - Controll table of courses
PROGRAMMER: QIN Yuren
PURPOSE: Define the relations between course and other class as well as a method to find random 3 courses
=end
class Course < ApplicationRecord
	has_many :comments
	has_many :users, through: :comments
    validates :code, uniqueness: {case_sensitive: false}

    def self.random()
        if Course.all.size <= 3
            return Course.all
        else
            random = Array.new
            random[0] = rand(Course.all.size) + 1
            random[1] = rand(Course.all.size) + 1
            until random[1] != random[0]
                random[1] = rand(Course.all.size) + 1
            end
            random[2] = rand(Course.all.size) + 1
            until random[2] != random[0] && random[2] != random[1]
                random[2] = rand(Course.all.size) + 1
            end
            return Course.where(:id => random)
        end
    end
end
