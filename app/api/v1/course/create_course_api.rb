module V1::Course
  class CreateCourseApi < Grape::API
    post '/courses' do
      { status: 'success' }
    end
  end
end
