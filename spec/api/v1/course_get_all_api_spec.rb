require 'rails_helper'

describe 'GET /api/v1/courses/all' do
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
    get '/api/v1/courses/all'
  end

  it 'return all course back' do
    json = JSON.parse(response.body)
    expect(json['course'].count).to be(3)
  end
end
