require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, name: "山田　三郎")
    activate @user
    activate @other_user
  end

  describe "ログインしている場合" do
    before do
      sign_in @user
    end
    it "@userが@other_userをフォローできること" do
      expect {post relationships_path, params: { followed_id: @other_user.id }}.to change{@user.following_user.count}.by(1)
    end
    it "@userが@other_userのフォローを解除できること" do
      @user.follow(@other_user)
      relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
      expect{delete relationship_path(relationship),xhr: true}.to change{@user.following_user.count}.by(-1)
    end
  end

  describe "ログインしていない場合" do
    it "createを実行しても、フォローできないこと" do
      expect{post relationships_path,xhr: true}.not_to change{@user.following_user.count}
    end
    it "createを実行しても、ログインページにリダイレクトすること" do
      post relationships_path,xhr: true
      expect(response).to redirect_to login_path
    end
    it "destroyを実行しても、フォロー解除できないこと" do
      expect{delete relationship_path(@other_user),xhr: true}.not_to change{@user.following_user.count}
    end
    it "destroyを実行しても、ログインページにリダイレクトすること" do
      delete relationship_path(@other_user),xhr: true
      expect(response).to redirect_to login_path
    end
  end
end
