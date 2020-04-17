require 'rails_helper'

RSpec.feature "UsersSignup", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "#new" do
    it "200レスポンスを返すこと、newテンプレートが表示されていること、@userがnewされていること" do
      get new_user_path
      aggregate_failures do
        expect(response).to have_http_status "200"
        expect(response).to render_template(:new)
        expect(assigns :user).to_not be_nil
      end
    end
  end

  describe "#show" do
    context "ログイン済みユーザーとして" do
      it "有効な値を返すこと" do
        activate @user
        sign_in @user
        get user_path(@user)
        expect(response).to have_http_status "200"
      end
    end
      context "ログインしていないユーザーとして" do
        it "ログインページにリダイレクトすること" do
          get user_path(@user)
          expect(response).to redirect_to "http://www.example.com/login"
        end
      end
    end
  # describe "#create" do
  #   context "有効な値の時" do
  #     before do
  #       @user = User.new
  #     end
  #     it "メールを送信できること" do
  #       user_params = FactoryBot.attributes_for(:user,:invalid_activated)
  #       post :create, params: {user: user_params }
  #       expect(ActionMailer::Base.deliveries.last.subject).to eq "Account activation"
  #     end
  #
  #     it "メールからアカウントを有効にできること" do
  #
  #     end
  #   end
  #   context "無効な値の時" do
  #     it "userを追加できないこと" do
  #       user_params = FactoryBot.attributes_for(:user,:invalid)
  #       expect{post :create, params: {user: user_params}}.not_to change{User.count}
  #     end
  #   end
  # end
end
