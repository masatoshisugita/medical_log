require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { FactoryBot.create(:relationship) }

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:relationship)).to be_valid
  end

  it "follower_idが空なら無効なこと" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "followed_idが空なら無効なこと" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

  it "follower_idとfollowed_idがユニークでないと無効なこと" do
    relationship.follower_id = 1
    relationship.followed_id = 2
    expect(FactoryBot.build(:relationship,follower_id: 1,followed_id: 2)).not_to be_valid
  end
end
