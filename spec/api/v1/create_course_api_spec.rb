require 'rails_helper'

describe 'Courses API', type: :request do
  describe 'POST /api/v1/courses' do
    def json
      JSON.parse(response.body)
    end

    let(:units) do
      2.times.map do |i|
        { unit_order: i + 1, unit_name: Faker::Lorem.word, unit_content: Faker::Lorem.word }
      end
    end

    let(:chapters) do
      3.times.map do |i|
        {
          chapter_order: i + 1,
          chapter_name: Faker::Lorem.word,
          units:
        }
      end
    end

    let(:course_info) do
      {
        course_name: Faker::Educator.course_name,
        instructor_name: Faker::Name.name,
        course_description: Faker::Lorem.paragraph,
        chapters:
      }
    end

    let(:valid_attributes) do
      { course_info: }
    end

    context 'when the request is valid' do
      before { post '/api/v1/courses', params: valid_attributes }

      it 'creates a course' do
        json = JSON.parse(response.body)
        expect(json['course']['course_name']).to eq(valid_attributes[:course_info][:course_name])
        expect(json['course']['instructor_name']).to eq(valid_attributes[:course_info][:instructor_name])
        expect(json['course']['course_description']).to eq(valid_attributes[:course_info][:course_description])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/courses', params: {} }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/course_info is missing, course_info\[course_name\] is missing, course_info\[instructor_name\] is missing, course_info\[course_description\] is missing, course_info\[chapters\] is missing/)
      end
    end

    context 'when chapter_order is a string' do
      before do
        invalid_attributes = valid_attributes.dup
        invalid_attributes[:course_info][:chapters].first[:chapter_order] = 'a'
        post '/api/v1/courses', params: invalid_attributes
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match('{"error":"course_info[chapters][0][chapter_order] is invalid"}')
      end
    end
  end
end
