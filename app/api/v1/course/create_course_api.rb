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
          course_info = params[:course_info]
          course_info[:course_id] = SecureRandom.hex(8)

          course_info[:chapters].each do |chapter|
            chapter[:chapter_id] = SecureRandom.hex(8)
            next unless chapter[:units]

            chapter[:units].each do |unit|
              unit[:unit_id] = SecureRandom.hex(8)
            end
          end

          { status: 'success', course: course_info }
        end
      end
    end
  end
end
