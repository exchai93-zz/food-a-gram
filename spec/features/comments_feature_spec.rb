require 'rails_helper'

feature 'reviewing' do
  before { Post.create caption: 'Avocado is the best' }

  scenario 'allows users to leave a comment using a form' do
    visit '/posts'
    click_link 'Comment'
    fill_in "Comment", with: 'This looks delicious'
    click_button 'Leave comment'

    expect(current_path).to eq '/posts'
    expect(page).to have_content 'This looks delicious'
  end
end
