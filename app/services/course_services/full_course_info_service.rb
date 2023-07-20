module CourseServices
  class FullCourseInfoService
    attr_accessor :course_identifier

    def initialize(course_identifier)
      @course_identifier = course_identifier
    end

    def execute
      course = ::Course.find_by(identifier: @course_identifier)
      return { error: 'Course not found' } unless course

      course_info = course.attributes
      course_info[:chapters] = course.chapters.includes(:units).order(:position).map do |chapter|
        chapter_info = chapter.attributes
        chapter_info[:units] = chapter.units.order(:position).map do |unit|
          unit_info = unit.attributes
          unit_info['unit_order'] = unit_info.delete('position')
          remove_unwanted_unit_attributes(unit_info)
          unit_info
        end
        chapter_info['chapter_order'] = chapter_info.delete('position')
        remove_unwanted_chapter_attributes(chapter_info)
        chapter_info
      end

      { course: course_info }
    end

    private

    def remove_unwanted_unit_attributes(unit_info)
      unit_info.delete('id')
      unit_info.delete('chapter_id')
    end

    def remove_unwanted_chapter_attributes(chapter_info)
      chapter_info.delete('id')
      chapter_info.delete('course_id')
    end
  end
end
