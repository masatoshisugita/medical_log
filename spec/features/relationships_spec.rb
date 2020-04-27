require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user,name: "山田　次郎")
    activate @user
    activate @other_user
    sign_in @user
  end

  scenario "「フォローする」のボタンがあること" do 
    visit user_path(@other_user)
    expect(page).to have_button "フォローする"
  end

  scenario "自分の詳細ページには、「フォローする」ボタンが無いこと"do
    visit user_path(@user)
    expect(page).not_to have_button "フォローする"
  end

  scenario "自分の詳細ページには、「フォロー解除する」ボタンが無いこと"do
    visit user_path(@user)
    expect(page).not_to have_button "フォロー解除する"
  end
  
  scenario "フォローすると「フォロー解除する」ボタンがあること" do
    visit user_path(@other_user)
    click_button "フォローする"
    expect(page).to have_button "フォロー解除する"
  end

  scenario "フォロー解除すると「フォローする」ボタンがあること" do
    visit user_path(@other_user)
    click_button "フォローする"
    click_button "フォロー解除する"
    expect(page).to have_button "フォローする"
  end

  scenario "フォローしている時、フォロー一覧ページが表示できること" do
    visit user_path(@other_user)
    click_button "フォローする"
    visit following_user_path(@user)
    expect(page).to have_link "#{@other_user.name}"
  end

  scenario "フォロワー一覧ページが表示できること" do
    visit user_path(@other_user)
    click_button "フォローする"
    visit followers_user_path(@other_user)
    expect(page).to have_link "#{@user.name}"
  end
end
