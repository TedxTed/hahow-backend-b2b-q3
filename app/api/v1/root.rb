module V1
  class Root < Grape::API
    version 'v1', using: :path

    format :json

    mount V1::Course::CreateCourseApi
  end
end
