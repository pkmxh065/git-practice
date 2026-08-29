require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        title: "Title",
        body: "MyText"
      ),
      Note.create!(
        title: "Title",
        body: "MyText"
      )
    ])
  end

  it "renders a list of notes" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
