module CourseServices
  class CourseCreateService
    attr_accessor :params

    def initialize(course_params)
      @params = course_params[:course_info]
    end

    def execute
      ActiveRecord::Base.transaction do
        course = create_course(
          course_name: params[:course_name],
          instructor_name: params[:instructor_name],
          course_description: params[:course_description]
        )

        create_chapter(course, params[:chapters])

        FullCourseInfoService.new(course.identifier).execute
      end
    rescue StandardError => e
      { errors: [e.record.errors.full_messages].flatten }
    end

    private

    def create_course(attributes)
      Course.create!(attributes)
    end

    def create_chapter(course, chapters)
      chapters.each do |chapter_params|
        chapter = course.chapters.create!(
          chapter_name: chapter_params[:chapter_name],
          position: chapter_params[:chapter_order]
        )
        create_unit(chapter, chapter_params[:units])
      end
    end

    def create_unit(chapter, units)
      units.each do |unit_params|
        chapter.units.create!(
          unit_name: unit_params[:unit_name],
          unit_description: unit_params[:unit_description],
          unit_content: unit_params[:unit_content]
        )
      end
    end
  end
end
