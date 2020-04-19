require 'rails_helper'

RSpec.describe "Topics", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @topic = FactoryBot.create(:topic)
    activate @user
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
      current_user = @user
      get edit_topic_path(@topic)
      aggregate_failures do
        expect(response).to have_http_status "200"
        expect(response).to render_template(:edit)
        expect(assigns :topic).to eq @topic
      end
    end
  end

end
