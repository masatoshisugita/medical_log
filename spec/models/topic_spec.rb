# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe '有効な値の時' do
    it 'topicが登録できること' do
      expect(FactoryBot.build(:topic)).to be_valid
    end

    it 'sick_nameが30文字以下なら登録できること' do
      expect(FactoryBot.build(:topic, sick_name: 'あ' * 30)).to be_valid
    end

    it 'periodが20文字以下なら登録できること' do
      expect(FactoryBot.build(:topic, period: 'い' * 20)).to be_valid
    end

    it 'initial_symptomが50文字以下なら登録できること' do
      expect(FactoryBot.build(:topic, initial_symptom: 'う' * 50)).to be_valid
    end

    it 'contentが400文字以下なら登録できること' do
      expect(FactoryBot.build(:topic, content: 'え' * 400)).to be_valid
    end
  end

  describe '無効な値の時' do
    it 'sick_nameが空なら登録できないこと' do
      topic = FactoryBot.build(:topic, sick_name: nil)
      topic.valid?
      expect(topic.errors[:sick_name]).to be_present
    end

    it 'sick_nameが31文字以上なら登録できないこと' do
      topic = FactoryBot.build(:topic, sick_name: 'a' * 31)
      expect(topic).not_to be_valid
      expect(topic.errors[:sick_name]).to be_present
    end

    it 'periodが21文字以上なら登録できないこと' do
      topic = FactoryBot.build(:topic, period: 'b' * 21)
      expect(topic).not_to be_valid
      expect(topic.errors[:period]).to be_present
    end

    it 'initial_symptomが51文字以上なら登録できないこと' do
      topic = FactoryBot.build(:topic, initial_symptom: 'c' * 51)
      expect(topic).not_to be_valid
      expect(topic.errors[:initial_symptom]).to be_present
    end

    it 'contentが空なら登録できないこと' do
      topic = FactoryBot.build(:topic, content: nil)
      topic.valid?
      expect(topic.errors[:content]).to be_present
    end

    it 'contentが401文字以上なら登録できないこと' do
      topic = FactoryBot.build(:topic, content: 'd' * 401)
      expect(topic).not_to be_valid
      expect(topic.errors[:content]).to be_present
    end
  end
end
