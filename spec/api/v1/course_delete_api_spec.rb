describe 'DELETE /api/v1/courses/:id' do
  let(:course) { create(:course) }
  let!(:chapter1) { create(:chapter, course:, position: 1) }
  let!(:chapter2) { create(:chapter, course:, position: 2) }
  let!(:unit1) { create(:unit, chapter: chapter1, position: 1) }
  let!(:unit2) { create(:unit, chapter: chapter1, position: 2) }
  let!(:unit3) { create(:unit, chapter: chapter2, position: 1) }

  before do
    delete "/api/v1/courses/#{course.id}"
  end

  it 'deletes the course' do
    expect(Course.find_by(id: course.id)).to be_nil
  end

  it 'deletes associated chapters of the course' do
    expect(Chapter.find_by(id: chapter1.id)).to be_nil
    expect(Chapter.find_by(id: chapter2.id)).to be_nil
  end

  it 'deletes units associated with the chapters of the course' do
    expect(Unit.find_by(id: unit1.id)).to be_nil
    expect(Unit.find_by(id: unit2.id)).to be_nil
    expect(Unit.find_by(id: unit3.id)).to be_nil
  end

  it 'returns a 204 No Content status' do
    expect(response).to have_http_status(200)
  end
end
