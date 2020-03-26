json.extract! course, :id, :name, :subject, :code, :description, :workload, :difficulty, :quality, :usefulness, :overall, :n_comments, :created_at, :updated_at
json.url course_url(course, format: :json)
