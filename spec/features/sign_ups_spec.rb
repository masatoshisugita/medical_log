require 'rails_helper'

RSpec.feature "Sign up", type: :feature do
  context "ユーザー登録" do
    scenario "有効な値ならユーザー登録ができる" do
      visit new_user_path
      fill_in "名前", with: "test user"
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "123abc"
      fill_in "パスワード（確認）", with: "123abc"
      expect{click_button "登録する"}.to change{User.count}.by(1)
      expect(page).to have_content "送信されたメールアドレスからアカウントを有効にしてください"
    end

    scenario "名前が無効な値ならユーザ登録できないこと" do
      visit new_user_path
      fill_in "名前", with: nil
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "123abc"
      fill_in "パスワード（確認）", with: "123abc"
      expect{click_button "登録する"}.not_to change{User.count}
      expect(page).to have_content "正確な値を入力してください"
    end

    scenario "メールアドレスが無効な値ならユーザ登録できないこと" do
      visit new_user_path
      fill_in "名前", with: "test user"
      fill_in "メールアドレス", with: "tester.example.com"
      fill_in "パスワード", with: "123abc"
      fill_in "パスワード（確認）", with: "123abc"
      expect{click_button "登録する"}.not_to change{User.count}
      expect(page).to have_content "正確な値を入力してください"
    end

    scenario "パスワードが無効な値ならユーザー登録ができないこと" do
      visit new_user_path
      fill_in "名前", with: "test user"
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "123"
      fill_in "パスワード（確認）", with: "123"
      expect{click_button "登録する"}.not_to change{User.count}
      expect(page).to have_content "正確な値を入力してください"
    end

    scenario "パスワードとパスワード（確認）が一致しないならユーザー登録ができないこと" do
      visit new_user_path
      fill_in "名前", with: "test user"
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "123abc"
      fill_in "パスワード（確認）", with: "abc123"
      expect{click_button "登録する"}.not_to change{User.count}
      expect(page).to have_content "正確な値を入力してください"
    end

    scenario "有効な値ならメールが送られること" do
      visit new_user_path
      fill_in "名前", with: "test user"
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "123abc"
      fill_in "パスワード（確認）", with: "123abc"
      click_button "登録する"

      mail = ActionMailer::Base.deliveries.last

      aggregate_failures do
        expect(mail.to).to eq ["tester1@example.com"]
        expect(mail.from).to eq ["noreply@example.com"]
        expect(mail.subject).to eq "Account activation"
        expect(mail.body.encoded).to match "Welcome to the MedicalLog!"
      end
    end
  end
end
