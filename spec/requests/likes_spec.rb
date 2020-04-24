require 'rails_helper'

RSpec.describe "Likes", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user =  FactoryBot.create(:user, name: "山田　三郎")
    @topic = FactoryBot.create(:topic,user_id: @other_user.id)
    activate @user
    activate @other_user
  end
  describe "#create & delete" do
    context "ログイン済みユーザーとして" do
      before do
        sign_in @user
      end
      it "@userが@other_userのtopicをいいねできること" do
        expect{post "/likes/#{@topic.id}/create",xhr: true}.to change{Like.count}.by(1)
      end
      it "@userが@other_userのtopicをいいねを解除できること" do
        @user.favorite(@topic)
        expect{post "/likes/#{@topic.id}/delete",xhr: true}.to change{Like.count}.by(-1)
      end
    end
    context "ログインしていないユーザーとして" do
      it "createを実行しても、ログインページにリダイレクトすること" do
        post "/likes/#{@topic.id}/delete",xhr: true
        expect(response).to redirect_to login_path
      end
      it "createを実行しても、いいねできないこと" do
        expect{post "/likes/#{@topic.id}/create",xhr: true}.not_to change{Like.count}
      end

      it "deleteteを実行したら、ログインページにリダイレクトすること" do
        post "/likes/#{@topic.id}/delete",xhr: true
        expect(response).to redirect_to login_path
      end
      it "deleteを実行しても、いいねできないこと" do
        expect{post "/likes/#{@topic.id}/delete",xhr: true}.not_to change{Like.count}
      end
    end
  end

  describe "#index" do
    context "ログイン済みユーザーとして" do
      it "200レスポンスを返すこと" do
        sign_in @user
        get "/likes/#{@user.id}/index"
        expect(response).to have_http_status "200"
      end
    end
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        get "/likes/#{@user.id}/index"
        expect(response).to redirect_to login_path
      end
    end
  end
end
