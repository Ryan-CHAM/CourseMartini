class Course < ApplicationRecord
	has_many :comments
	has_many :users, through: :comments
    
    def self.search(search)
        if search
            i = search.size
            j = 0
            results = Array.new
            Course.all.each do |course|
                if search == course.code[0..i - 1]
                    results[j] = course.code
                    j = j + 1
                end
            end
            if results
                Course.where(code: results)
            end
        else
            @courses = Course.all
        end
    end
end
