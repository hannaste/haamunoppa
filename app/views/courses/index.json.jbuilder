json.array!(@courses) do |course|
  json.extract! course, :id, :name, :code, :description, :credits, :period, :department, :rating
  json.url course_url(course, format: :json)
end
