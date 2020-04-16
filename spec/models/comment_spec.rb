require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  it "reviewが空なら無効なこと" do
    comment = FactoryBot.build(:comment,review: nil)
    comment.valid?
    expect(comment.errors[:review]).to include("コメントが空になっています")
  end

  it "reviewが151文字以上なら無効なこと" do
    comment = FactoryBot.build(:comment,review: "あ" * 151)
    expect(comment).not_to be_valid
    expect(comment.errors[:review]).to be_present
  end

  it "user_idが空なら無効なこと" do
    comment = FactoryBot.build(:comment, user_id: nil)
    expect(comment).not_to be_valid
    expect(comment.errors[:user_id]).to be_present
  end

  it "topic_idが空なら無効なこと" do
    comment = FactoryBot.build(:comment, topic_id: nil)
    expect(comment).not_to be_valid
    expect(comment.errors[:topic_id]).to be_present
  end
end
