require 'spec_helper'

describe "Home" do
  it "gets index" do
    visit root_path

    expect(page.status_code).to eq(200)
    expect(page).to have_css('h1', text: 'Relate')
    expect(page).to have_content('Relationship management for community organizers')
  end
end
