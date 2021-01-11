# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '有効な値の時' do
    it 'userを登録できること' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'nameが15文字以下なら登録できること' do
      expect(FactoryBot.build(:user, name: 'あ' * 15)).to be_valid
    end

    it 'emailが255文字以下なら登録できること' do
      expect(FactoryBot.build(:user, email: 'a' * 243 + '@example.com')).to be_valid
    end

    it 'passwordが6文字以上なら登録できること' do
      expect(FactoryBot.build(:user, password: 'a' * 6, password_confirmation: 'a' * 6)).to be_valid
    end
  end

  describe '無効な値の時' do
    it 'nameが空なら登録できないこと' do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to be_present
    end

    it 'nameが16文字以上なら登録できないこと' do
      user = FactoryBot.build(:user, name: 'あ' * 16)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to be_present
    end

    it 'emailが空なら登録できないこと' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to be_present
    end

    it 'emailが256文字以上なら登録できないこと' do
      user = FactoryBot.build(:user, email: 'a' * 256 + '@com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it '同じemailがデータにあると登録できないこと' do
      user1 = FactoryBot.create(:user, email: 'tester@example.com')
      user2 = FactoryBot.build(:user, email: 'tester@example.com')
      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to be_present
    end

    it '@がないemailは登録できないこと' do
      user = FactoryBot.build(:user, email: '123com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'passwordが空なら登録できないこと' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it 'passwordが5文字以下なら登録できないこと' do
      user = FactoryBot.build(:user, password: 'a' * 5)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it 'password_confirmationが空なら登録できないこと' do
      user = FactoryBot.build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it 'passwordとpassword_confirmationが一致していないと登録できないこと' do
      user = FactoryBot.build(:user, password: 'abc123', password_confirmation: '123abc')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to be_present
    end
  end
end
