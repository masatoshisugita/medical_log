require 'rails_helper'

RSpec.describe Like, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:like)).to be_valid
  end

  it "user_idが空なら無効なこと" do
    favorite = FactoryBot.build(:like, user_id: nil)
    expect(favorite).not_to be_valid
    expect(favorite.errors[:user_id]).to be_present
  end

  it "topic_idが空なら無効なこと" do
    favorite = FactoryBot.build(:like, topic_id: nil)
    expect(favorite).not_to be_valid
    expect(favorite.errors[:topic_id]).to be_present
  end
end
