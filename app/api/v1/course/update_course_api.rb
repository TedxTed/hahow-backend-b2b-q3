module V1
  module Course
    class CreateCourseApi < Grape::API
      resource :courses do
        patch  do
          desc 'update a new course'

          params do
            requires :course, type: Hash do
              requires :id, type: String, desc: 'Course identifier'
              optional :course_name, type: String, desc: 'Name of the course'
              optional :instructor_name, type: String, desc: 'Name of the instructor'
              optional :course_description, type: String, desc: 'Description of the course'

              optional :chapters, type: Array do
                requires :id, type: String, desc: 'Chapter identifier'
                optional :chapter_name, type: String, desc: 'Name of the chapter'

                optional :units, type: Array do
                  requires :id, type: String, desc: 'Unit identifier'
                  optional :unit_name, type: String, desc: 'Name of the unit'
                  optional :unit_description, type: String, desc: 'Description of the unit'
                  optional :unit_content, type: String, desc: 'Content of the unit'
                  optional :unit_order, type: Integer, desc: 'Order of the unit'
                end
              end
            end
          end
        end
      end
    end
  end
end
