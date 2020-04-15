require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "有効な値を持つこと" do
    expect(FactoryBot.build(:topic)).to be_valid
  end

  it "sick_nameが空なら無効なこと" do
    topic = FactoryBot.build(:topic, sick_name: nil)
    topic.valid?
    expect(topic.errors[:sick_name]).to include("病気の名前が空になっています")
  end

  it "sick_nameが31文字以上なら無効なこと" do
    topic = FactoryBot.build(:topic, sick_name: "a" * 31)
    expect(topic).not_to be_valid
    expect(topic.errors[:sick_name]).to be_present
  end

  it "periodが21文字以上なら無効なこと" do
    topic = FactoryBot.build(:topic, period: "b" * 21)
    expect(topic).not_to be_valid
    expect(topic.errors[:period]).to be_present
  end

  it "initial_symptomが51文字以上なら無効なこと" do
    topic = FactoryBot.build(:topic, initial_symptom: "c" * 51)
    expect(topic).not_to be_valid
    expect(topic.errors[:initial_symptom]).to be_present
  end

  it "contentが空なら無効なこと" do
    topic = FactoryBot.build(:topic, content: nil)
    topic.valid?
    expect(topic.errors[:content]).to include("内容が空になっています")
  end

  it "contentが401文字以上なら無効なこと" do
    topic = FactoryBot.build(:topic, content: "d" * 401)
    expect(topic).not_to be_valid
    expect(topic.errors[:content]).to be_present
  end
end
