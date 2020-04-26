require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end
  scenario "有効な値ならユーザーがログインできること" do    
    activate @user
    visit login_path
    fill_in "メールアドレス", with: "tester1@example.com"
    fill_in "パスワード", with: "abc123"
    click_button "ログインする"
    
    expect(page).to have_content "ログインしました"
  end

  scenario "有効化されていないユーザーはログインできないこと" do
    visit login_path
    fill_in "メールアドレス", with: "tester2@example.com"
    fill_in "パスワード", with: "abc123"
    click_button "ログインする"
    
    expect(page).to have_content "送信されたメールでアカウントを有効化してください"
  end

  scenario "無効な値ならユーザーはログインできないこと" do
    activate @user
    visit login_path
    fill_in "メールアドレス", with: "tester300@example.com"
    fill_in "パスワード", with: "abc123"
    click_button "ログインする"
    
    expect(page).to have_content "メールアドレスもしくはパスワードが有効ではありません"
  end
end
