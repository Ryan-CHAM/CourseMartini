json.extract! course, :id, :code, :name, :subject, :faculty, :description, :workload, :difficulty, :quality, :usefulness, :gpa, :overall, :n_comments, :book, :url, :created_at, :updated_at, :instructor
json.url course_url(course, format: :json)
