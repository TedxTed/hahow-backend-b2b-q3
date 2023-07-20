require 'grape-swagger'

module V1
  class Root < Grape::API
    version 'v1', using: :path

    format :json

    mount V1::Course::CreateCourseApi
    mount V1::Course::UpdateCourseApi
    mount V1::Course::DeleteCourseApi
    add_swagger_documentation
  end
end
