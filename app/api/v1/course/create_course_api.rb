module V1
  module Course
    class CreateCourseApi < Grape::API
      resource :courses do
        desc 'Create a new course'
        params do
          requires :course_info, type: Hash do
            requires :course_name, type: String, desc: 'Course name'
            requires :instructor_name, type: String, desc: 'Instructor name'
            requires :course_description, type: String, desc: 'Course description'
            requires :chapters, type: Array do
              requires :chapter_order, type: Integer, desc: 'Chapter order'
              requires :chapter_name, type: String, desc: 'Chapter name'
              requires :units, type: Array do
                requires :unit_order, type: Integer, desc: 'Unit order'
                requires :unit_name, type: String, desc: 'Unit name'
              end
            end
          end
        end

        post do
          result = ::CourseServices::CourseCreateService.new(params).execute
          if result[:errors]
            error!({ status: 'error', errors: result[:errors] }, 422)
          else
            { status: 'success', course: result[:course] }
          end
        end
      end
    end
  end
end
