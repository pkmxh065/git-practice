require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it 'is valid with title and body' do
      note = Note.new(title: 'Test Title', body: 'Test Body')
      expect(note).to be_valid
    end

    it 'is invalid without title' do
      note = Note.new(title: nil, body: 'Test Body')
      expect(note).to_not be_valid
      expect(note.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without body' do
      note = Note.new(title: 'Test Title', body: nil)
      expect(note).to_not be_valid
      expect(note.errors[:body]).to include("can't be blank")
    end
  end
end
