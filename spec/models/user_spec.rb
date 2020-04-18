require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "nameが空なら無効なこと" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("名前が空になっています")
  end

  it "nameが16文字以上なら無効なこと" do
    user = FactoryBot.build(:user, name: "あ" * 16 )
    expect(user).not_to be_valid
    expect(user.errors[:name]).to be_present
  end

  it "emailが空なら無効なこと" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("メールアドレスが空になっています")
  end

  it "emailが256文字以上なら無効なこと" do
    user = FactoryBot.build(:user, email: "a" * 256 + "@com")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it "同じemailがデータにあると無効なこと" do
    user1 = FactoryBot.create(:user,email: "tester@example.com")
    user2 = FactoryBot.build(:user, email: "tester@example.com")
    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to be_present
  end

  it "@がないemailは無効なこと" do
    user = FactoryBot.build(:user, email: "123com")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it "passwordが空なら無効なこと" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("パスワードが空になっています")
  end

  it "passwordが5文字以下なら無効なこと" do
    user = FactoryBot.build(:user, password: "a" * 5)
    expect(user).not_to be_valid
    expect(user.errors[:password]).to be_present
  end

  it "password_confirmationが空なら無効なこと" do
    user = FactoryBot.build(:user, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("パスワード（確認）が空になっています")
  end

  it "passwordとpassword_confirmationが一致していないと無効なこと" do
    user = FactoryBot.build(:user, password: "abc123",password_confirmation: "123abc")
    expect(user).not_to be_valid
    expect(user.errors[:password_confirmation]).to be_present
  end

  it "followでユーザーをフォローできること" do

  end

  it "unfollowでユーザーのフォローを解除できること" do

  end
end
