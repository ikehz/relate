require 'spec_helper'

describe "Tags" do
  let (:user) { User.make! }

  before do
    @tag = Tag.make!(owner: user)
    @new_tag = Tag.make(owner: user)
  end

  context "a user" do
    before do
      sign_in user
    end

    it "gets the index" do
      visit tags_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(tags_path)
      expect(page).to have_content(@tag.name)
    end

    it "creates a new tag" do
      visit tags_path

      expect{
        click_link 'New Tag'
        fill_in 'Name', with: @new_tag.name
        click_button 'Create Tag'
      }.to change(Tag, :count).by 1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(tag_path(Tag.find_by_name(@new_tag.name)))
      expect(page).to have_content('Tag was successfully created.')
      expect(page).to have_content(@new_tag.name)
    end

    it "shows a tag" do
      visit tag_path(@tag)

      expect(page.status_code).to eq(200)
      expect(page).to have_content(@tag.name)
    end

    it "edits a tag" do
      visit tag_path(@tag)

      click_link 'Edit Tag'
      fill_in 'Name', with: @new_tag.name
      click_button 'Update Tag'

      expect(@tag.reload.name).to eq(@new_tag.name)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(tag_path(@tag))
      expect(page).to have_content('Tag was successfully updated.')
      expect(page).to have_content(@new_tag.name)
    end

    it "destroys a tag" do
      visit tags_path

      expect{
        click_link 'Delete'
      }.to change(Tag, :count).by -1

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(tags_path)
      expect(page).to_not have_content(@tag.name)
    end
  end
end
