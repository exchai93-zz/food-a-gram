require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should display a prompt to post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
  end

  context 'posts have been added' do
    before do
      Post.create(caption: 'My first post')
    end

    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content 'My first post'
      expect(page).not_to have_content 'No posts yet'
    end
  end

  context 'creating posts' do
    scenario 'prompts user to upload photo, then displays the new post' do
      visit '/posts'
      click_link 'Add a post'
      fill_in 'Caption', with: 'Avocado is the best'
      click_button 'Post'
      expect(page).to have_cotent 'Avocado is the best'
      expect(current_paht).to eq '/posts'
    end
  end

  context 'viewing posts' do
    let!(:avocado) { Post.create(caption:'Avocado is the best') }

    scenario 'lets a user view a post' do
      visit '/posts'
      click_link 'Avocado is the best'
      expect(page).to have_content 'Avocado is the best'
      expect(current_path).to eq '/posts/#{avocado.id}'
    end
  end
end
