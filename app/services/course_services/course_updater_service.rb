module CourseServices
  class CourseUpdaterService
    attr_reader :params

    def initialize(update_params)
      @params = update_params
    end

    def execute
      ActiveRecord::Base.transaction do
        course = update_course(params[:course])
        update_chapter(course, params[:course][:chapters])
        FullCourseInfoService.new(course.identifier).execute
      end
    rescue ActiveRecord::RecordNotFound => e

      entity, criteria = parse_error_message(e.message)
      custom_message = "Unable to find #{entity}. Please ensure the details are correct and try again."
      { errors: [custom_message] }
    rescue StandardError => e
      { errors: [e.message] }
    end

    private

    def update_course(course_params)
      course = Course.find_by!(identifier: course_params[:id])

      attributes_to_update = %i[instructor_name description course_name]
      update_attribute = course_params.slice(*attributes_to_update)

      course.update!(update_attribute)
      course.reload
    end

    def update_chapter(course, chapters_params)
      chapters_params.each do |chapter_param|

        chapter = course.chapters.find_by!(identifier: chapter_param[:id]) if chapter_param[:id]
        if chapter
          attributes_to_update = %i[chapter_name]
          update_attribute = chapter_param.slice(*attributes_to_update)
          chapter.update!(update_attribute)

          chapter.insert_at(chapter_param[:chapter_order]) if chapter_param[:chapter_order]

          update_units(chapter, chapter_param[:units])
        else
          new_chapter = course.chapters.create!(chapter_name: chapter_param[:chapter_name])

          if chapter_param[:chapter_order]
            new_chapter.insert_at(chapter_param[:chapter_order])
          else
            new_chapter.move_to_bottom
          end
        end
      end
    end

    def update_units(chapter, units_params)
      units_params.each do |unit_param|
        unit = chapter.units.find_by!(identifier: unit_param[:id]) if unit_param[:id]
        if unit
          attributes_to_update = %i[unit_name unit_description unit_content]
          update_attribute = unit_param.slice(*attributes_to_update.compact)
          unit.update!(update_attribute)

          unit.insert_at(unit_param[:unit_order]) if unit_param[:unit_order]
        else
          new_unit_attributes = {
            unit_name: unit_param[:unit_name],
            unit_description: unit_param[:unit_description],
            unit_content: unit_param[:unit_content]
          }.compact
          new_unit = chapter.units.create!(new_unit_attributes)

          if unit_param[:unit_order]
            new_unit.insert_at(unit_param[:unit_order])
          else
            new_unit.move_to_bottom
          end
        end
      end
    end

    def parse_error_message(message)
      if match_data = message.match(/Couldn't find (\w+) with/)
        entity = match_data[1]
        criteria = message.split('[WHERE').last
        [entity, criteria]
      else
        [nil, nil]
      end
    end
  end
end
