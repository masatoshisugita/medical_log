require 'rails_helper'

RSpec.describe "Topics", type: :request do
  before do
    #@userと@topicが紐付いている
    @user = FactoryBot.create(:user)
    @other_user =  FactoryBot.create(:user, name: "山田　三郎")
    @topic = FactoryBot.create(:topic,user_id: @user.id)
    activate @user
    activate @other_user
    sign_in @user
  end
  describe "#new" do
    it "200レスポンスを返すこと、newテンプレートが表示されていること、@topicがnewされていること" do
      get new_topic_path
      aggregate_failures do
        expect(response).to have_http_status "200"
        expect(response).to render_template(:new)
        expect(assigns :topic).not_to be_nil
      end
    end
  end

  describe "#show" do
    it "200レスポンスを返すこと" do
      get topic_path(@topic)
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do
    context "値が有効な時" do
      it "topicを追加できること" do
        topic_params = FactoryBot.attributes_for(:topic)
        expect {post topics_path(topic: topic_params)}.to change{Topic.count}.by(1)
      end
    end
    context "値が無効な時" do
      it "topicを追加できないこと" do
        topic_params = FactoryBot.attributes_for(:topic, sick_name: nil)
        expect {post topics_path(topic: topic_params)}.not_to change{Topic.count}
      end
    end
  end

  describe "#edit" do
    it "200レスポンスを返すこと、editテンプレートが表示されていること、@topicが取得されていること" do
      get edit_topic_path(@topic)
      aggregate_failures do
        expect(response).to have_http_status "200"
        expect(response).to render_template(:edit)
        expect(assigns :topic).to eq @topic
      end
    end
  end
  describe "#update" do
    context "値が有効な時" do
      it "topicを更新できること" do
        topic_params = FactoryBot.attributes_for(:topic, sick_name: "熱")
        put topic_path(@topic), params: { topic: topic_params }
        expect(@topic.reload.sick_name).to eq "熱"
      end
      it "@other_userは更新できないこと" do
        topic_params = FactoryBot.attributes_for(:topic, sick_name: "熱")
        sign_in @other_user
        put topic_path(@topic), params: { topic: topic_params }
        expect(@topic.reload.sick_name).to eq "風邪"
      end
    end
    context "値が無効な時" do
      it "topicを更新できないこと" do
        topic_params = FactoryBot.attributes_for(:topic, sick_name: nil)
        put topic_path(@topic), params: { topic: topic_params }
        expect(@topic.reload.sick_name).to eq "風邪"
      end
    end
  end

  describe "#destroy" do
    context "ログインユーザーとtopicを作成したユーザーが同じなら" do
      it "topicを削除できること" do
        expect {delete topic_path(@topic)}.to change{Topic.count}.by(-1)
      end
    end
    context "ログインユーザーとtopicを作成したユーザーが違うなら" do
      it "topicを削除できないこと" do
        sign_in @other_user
        expect {delete topic_path(@topic)}.not_to change{Topic.count}
      end
    end
  end
  describe "#index" do
    it "200レスポンスを返すこと" do
      get root_path
      expect(response).to have_http_status "200"
    end
  end
end
