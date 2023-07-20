require 'rails_helper'

describe 'GET /api/v1/courses/:id' do
  3.times do |course_index|
    let!("course#{course_index + 1}".to_sym) do
      course = create(:course)

      2.times do |chapter_index|
        chapter = create(:chapter, course:, position: chapter_index + 1)

        unit_count = 3
        unit_count.times do |unit_index|
          create(:unit, chapter:, position: unit_index + 1)
        end
      end

      course
    end
  end

  before do
    get "/api/v1/courses/#{course1.identifier}"
  end

  it 'return specfic course back' do
    json = JSON.parse(response.body)
    expect(json['course']['course']['course_name']).to eq(course1.course_name)
  end
end
