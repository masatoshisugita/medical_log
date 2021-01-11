# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '有効な値の時' do
    it 'commentが登録できること' do
      expect(FactoryBot.build(:comment)).to be_valid
    end

    it 'commentがreviewが150文字以内なら登録できること' do
      expect(FactoryBot.build(:comment, review: 'あ' * 150)).to be_valid
    end
  end

  describe '無効な値の時' do
    it 'reviewが空なら登録できないこと' do
      comment = FactoryBot.build(:comment, review: nil)
      comment.valid?
      expect(comment.errors[:review]).to be_present
    end

    it 'reviewが151文字以上なら登録できないこと' do
      comment = FactoryBot.build(:comment, review: 'あ' * 151)
      expect(comment).not_to be_valid
      expect(comment.errors[:review]).to be_present
    end

    it 'user_idが空なら登録できないこと' do
      comment = FactoryBot.build(:comment, user_id: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:user_id]).to be_present
    end

    it 'topic_idが空なら登録できないこと' do
      comment = FactoryBot.build(:comment, topic_id: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:topic_id]).to be_present
    end
  end
end
