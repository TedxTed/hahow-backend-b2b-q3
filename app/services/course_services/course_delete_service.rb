module CourseServices
  class CourseDeleteService
    attr_reader :params

    def initialize(delete_params)
      @params = delete_params
    end

    def execute
      ActiveRecord::Base.transaction do
        course = Course.find_by!(identifier: params[:id])
        course.destroy
        { success: true }
      rescue ActiveRecord::RecordNotFound => e
        entity, = parse_error_message(e.message)
        custom_message = "Unable to find #{entity}. Please ensure the details are correct and try again."
        { errors: [custom_message] }
      rescue StandardError => e
        { errors: [e.message] }
      end
    end

    private

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
