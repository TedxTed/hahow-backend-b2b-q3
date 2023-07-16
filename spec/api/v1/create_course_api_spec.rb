require 'rails_helper'

describe 'Courses API', type: :request do
  describe 'POST /api/v1/courses' do
    let(:units) do
      2.times.map do |i|
        { unit_order: i + 1, unit_name: Faker::Lorem.word }
      end
    end

    let(:chapters) do
      3.times.map do |i|
        {
          chapter_order: i + 1,
          chapter_name: Faker::Lorem.word,
          units: i < 2 ? units : []
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
        expect(json['course']['course_name']).to eq(valid_attributes[:course_info][:course_name])
        expect(json['course']['instructor_name']).to eq(valid_attributes[:course_info][:instructor_name])
        expect(json['course']['course_description']).to eq(valid_attributes[:course_info][:course_description])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/courses', params: {} } # Changed line

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Course info can't be blank/)
      end
    end
  end
end
