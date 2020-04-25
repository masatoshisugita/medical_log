require 'rails_helper'

RSpec.feature "Users", type: :feature do
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

  # context "ユーザー編集" do
  #   before do
  #     @user = FactoryBot.create(:user)
  #     activate @user
  #     sign_in @user
  #     visit user_path(@user)
  #     click_link "編集"
  #   end
  #
  #   xscenario "「@user.nameの編集」という文字が表示されていること" do
  #     expect(page).to have_content "#{@user.name}の編集"
  #   end
  #
  #   scenario "有効な値ならユーザー編集できること" do
  #     fill_in "名前", with: "山田　一郎"
  #     fill_in "メールアドレス", with: "tester100@example.com"
  #     fill_in "パスワード", with: "1a1a1a"
  #     fill_in "パスワード（確認）", with: "1a1a1a"
  #     click_button "編集する"
  #     expect(page).to have_content "ユーザーを編集しました。"
  #     expect(@user.reload.name).to eq "山田　一郎"
  #     expect(@user.reload.email).to eq "tester100@example.com"
  #     expect(@user.reload.password).to eq "1a1a1a"
  #     expect(@user.reload.password_confirmation).to eq "1a1a1a"
  #   end
  #
  #   xscenario "無効な値ならユーザー編集できないこと" do
  #     fill_in "名前", with: nil
  #     fill_in "メールアドレス", with: "tester100@example.com"
  #     fill_in "パスワード", with: "123456"
  #     fill_in "パスワード（確認）", with: "123456"
  #     click_button "編集する"
  #     expect(page).to have_content "正確な値を入力してください"
  #     expect(@user.reload.name).not_to eq nil
  #   end
  # end
end
