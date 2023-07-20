module V1
  module Course
    class GetAllCourseApi < Grape::API
      resource :courses do
        desc 'Create a new course'

        get '/all' do
          course_identifier_collection = ::Course.all.pluck(:identifier)

          result = course_identifier_collection.map do |course_identifier|
            CourseServices::FullCourseInfoService.new(course_identifier).execute
          end

          { status: 'success', course: result }
        end
      end
    end
  end
end
