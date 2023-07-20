module V1
  module Course
    class GetSpecficCourseApi < Grape::API
      resource :courses do
        desc 'Create a new course'

        params do
          requires :id, type: String, desc: 'Course ID'
        end

        get '/:id' do
          result = CourseServices::FullCourseInfoService.new(params[:id]).execute

          { status: 'success', course: result }
        end
      end
    end
  end
end
