class Course < ApplicationRecord
	has_many :comments
	has_many :users, through: :comments
    validates :code, uniqueness: {case_sensitive: false}

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
        end
    end
    
    def self.random()
        random = Array.new
        random[0] = rand(Course.all.size) + 1
        random[1] = rand(Course.all.size) + 1
        until random[1] != random[0]
            random[1] = rand(Course.all.size) + 1
        end
        random[2] = rand(Course.all.size) + 1
        until random[2] != random[0] && random[2] != random[0]
            random[2] = rand(Course.all.size) + 1
        end
        Course.where(:id => random)
    end
end
