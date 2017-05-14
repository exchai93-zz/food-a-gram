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
    let!(:avocado) { Post.create(caption: 'Avocado is the best') }

    scenario 'lets a user view a post' do
      visit '/posts'
      click_link 'Avocado is the best'
      expect(page).to have_content 'Avocado is the best'
      expect(current_path).to eq '/posts/#{avocado.id}'
    end
  end

  context 'editing posts' do

    before { Post.create caption: 'Avocado is the best' }
    scenario 'let a user edit a post' do
      visit '/posts'
      click_link 'Edit AVOCADO IS THE BEST'
      fill_in 'Caption', with: 'AVOCADO IS THE BEST'
      click_button 'Update Post'
      click_link 'AVOCADO IS THE BEST'
      expect(page).to have_content 'AVOCADO IS THE BEST'
      expect(current_path).to eq '/posts/1'
    end
  end

  context 'deleting posts' do

    before { Post.create caption: 'Avocado is the best' }
    scenario 'removes a post when a user clicks a delete link' do
      visit '/posts'
      click_link 'Delete Avocado is the best'
      expect(page).not_to have_content 'Avocado is the best'
      expect(page).to have_content 'Post deleted'
    end
  end
end
