require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user =  FactoryBot.create(:user, name: "山田　三郎")
    @topic = FactoryBot.create(:topic,user_id: @user.id)
    activate @user
    activate @other_user
  end
  #　後日実装
  # describe "#create" do
  #   context "有効な値の時" do
  #     it "コメントできること" do
  #       sign_in @other_user
  #       #comments = @topic.comments
  #       comment_params = FactoryBot.attributes_for(:comment)
  #       expect{post topic_comments_path(topic_id: @topic.id, comment: comment_params), xhr: true }.to change{Comment.count}.by(1)
  #     end
  #   end
  # end
end
 #delete topic_comment
