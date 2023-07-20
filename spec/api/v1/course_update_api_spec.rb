require 'rails_helper'

describe 'Courses API', type: :request do
  describe 'PATCH /api/v1/courses' do
    let(:course) { create(:course) }
    let(:chapter1) { create(:chapter, course:, position: 1) }
    let(:chapter2) { create(:chapter, course:, position: 2) }
    let(:unit1) { create(:unit, chapter: chapter1, position: 1) }
    let(:unit2) { create(:unit, chapter: chapter1, position: 2) }
    let(:unit3) { create(:unit, chapter: chapter1, position: 3) }

    let!(:unit_update_params) do
      {
        course: {
          id: course.identifier,
          course_name: 'new_course_name',
          instructor_name: 'new_instructor_name',
          course_description: 'new_description',
          chapters: [
            {
              id: chapter1.identifier,
              chapter_name: 'new_chapter_name',
              units: [
                {
                  id: unit3.identifier,
                  unit_name: 'new_unit_name',
                  unit_description: 'new_description',
                  unit_content: 'new_content',
                  unit_order: 3
                }
              ]
            }
          ]
        }
      }
    end

    context 'when the request is valid' do
      before { patch '/api/v1/courses', params: unit_update_params }

      let(:parsed_response) { JSON.parse(response.body) }

      it 'returns a successful status' do
        expect(parsed_response['status']).to eq('success')
      end

      it 'updates the course attributes' do
        expect(parsed_response.dig('course', 'course_name')).to eq('new_course_name')
        expect(parsed_response.dig('course', 'instructor_name')).to eq('new_instructor_name')
      end

      it 'updates the chapter attributes' do
        chapter_response = parsed_response.dig('course', 'chapters', 0)

        expect(chapter_response['chapter_name']).to eq('new_chapter_name')
        expect(chapter_response.dig('units', 0, 'unit_content')).to eq('new_content')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the chapter id is invalid' do
      before do
        unit_update_params[:course][:chapters][0][:id] = 'invalid_id'
        patch '/api/v1/courses', params: unit_update_params
      end

      it 'returns an error response' do
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the unit id is invalid' do
      before do
        unit_update_params[:course][:chapters][0][:units][0][:id] = 'invalid_id'
        patch '/api/v1/courses', params: unit_update_params
      end

      it 'returns an error response' do
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
