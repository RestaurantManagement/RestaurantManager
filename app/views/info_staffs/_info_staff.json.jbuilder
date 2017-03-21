	json.extract! info_staff, :id, :name, :age,:nation, :description, :Staff_id, :created_at, :updated_at
json.url info_staff_url(info_staff, format: :json)
