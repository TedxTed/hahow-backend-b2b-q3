module V1
  module Course
    class DeleteCourseApi < Grape::API
      resource :courses do
        desc 'Delete a course'

        params do
          requires :id, type: String, desc: 'Course ID'
        end

        delete '/:id' do
          result = CourseServices::CourseDeleteService.new(params).execute

          if result[:errors]
            error!({ status: 'error', errors: result[:errors] }, 422)
          else
            { status: 'success' }
          end
        end
      end
    end
  end
end
