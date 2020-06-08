# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Relationships', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, name: '山田　次郎')
    activate @user
    activate @other_user
    sign_in @user
  end

  scenario '「フォローする」のボタンがあること' do
    visit user_path(@other_user)
    expect(page).to have_button 'フォローする'
  end

  scenario '自分の詳細ページには、「フォローする」ボタンが無いこと' do
    visit user_path(@user)
    expect(page).not_to have_button 'フォローする'
  end

  scenario '自分の詳細ページには、「フォロー解除」ボタンが無いこと' do
    visit user_path(@user)
    expect(page).not_to have_button 'フォロー解除'
  end

  scenario 'フォローすると「フォロー解除」ボタンがあること' do
    visit user_path(@other_user)
    click_button 'フォローする'
    expect(page).to have_button 'フォロー解除'
  end

  scenario 'フォローしてフォロー解除すると「フォローする」ボタンがあること' do
    visit user_path(@other_user)
    click_button 'フォローする'
    click_button 'フォロー解除'
    expect(page).to have_button 'フォローする'
  end

  scenario 'フォローしている時、フォロー一覧ページに名前が表示できること' do
    visit user_path(@other_user)
    click_button 'フォローする'
    visit following_user_path(@user)
    expect(page).to have_link @other_user.name.to_s
  end

  scenario 'フォローされている時、フォロワー一覧ページに名前が表示できること' do
    visit user_path(@other_user)
    click_button 'フォローする'
    visit followers_user_path(@other_user)
    expect(page).to have_link @user.name.to_s
  end
end
