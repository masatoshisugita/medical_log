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
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        get user_path(@user)
        expect(response).to redirect_to(login_url)
      end
    end
    context "ログイン済みユーザーとして" do
      it "200レスポンスを返すこと" do
        activate @user
        sign_in @user
        get user_path(@user)
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#edit" do
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        get edit_user_path(@user)
        expect(response).to redirect_to(login_url)
      end
    end
    context "ログイン済みユーザーとして" do
      it "200レスポンスを返すこと,editテンプレートが表示されていること,@userが取得できていること" do
        activate @user
        sign_in @user
        get edit_user_path(@user)

        aggregate_failures do
          expect(response).to have_http_status "200"
          expect(response).to render_template(:edit)
          expect(assigns :user).to eq @user
        end
      end
    end
  end

  describe "#destroy" do
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        delete user_path(@user)
        expect(response).to redirect_to(login_url)
      end
    end
    context "ログイン済みユーザーとして" do
      it "ユーザーを削除できること" do
        activate @user
        sign_in @user
        expect {delete user_path(@user)}.to change{User.count}.by(-1)
      end
    end
  end

  describe "#update" do
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        put user_path(@user)
        expect(response).to redirect_to(login_url)
      end
    end
    context "ログイン済みユーザーとして" do
      before do
        activate @user
        sign_in @user
      end
      it "値が有効なら、ユーザーを編集できること" do
        user_params = FactoryBot.attributes_for(:user,name: "鈴木　一郎")
        put user_path(@user), params: { user: user_params }
        expect(@user.reload.name).to eq "鈴木　一郎"
      end
      it "値が無効なら、ユーザーを編集できないこと" do
        user_params = FactoryBot.attributes_for(:user,name: nil)
        put user_path(@user), params: { user: user_params }
        expect(@user.reload.name).to eq "田中　太郎"
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#create" do
    context "値が有効な場合" do
      let(:send_mail) { ActionMailer::Base.deliveries.last }

      it "ユーザーが登録されること" do
        user_params = FactoryBot.attributes_for(:user)
        expect {post users_path(user: user_params)}.to change{User.count}.by(1)
      end
      it "メールを送信できること" do
        user_params = FactoryBot.attributes_for(:user)
        expect { post users_path(user: user_params) }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "件名がAccount activationであること" do
        user_params = FactoryBot.attributes_for(:user)
        post users_path(user: user_params)
        expect(send_mail.subject).to eq "Account activation"
      end
    end
    context "無効な値の時" do
      it "ユーザーを登録できないこと" do
        user_params = FactoryBot.attributes_for(:user,:invalid)
        expect {post users_path(user: user_params)}.not_to change{User.count}
      end
    end
  end

  describe "#following" do
    context "ログインしていないユーザーとして" do
      it "ログインページにリダイレクトすること" do
        get following_user_path(@user)
        expect(response).to redirect_to(login_url)
      end
    end
    context "ログイン済みユーザーとして" do
      before do
        @other_user = FactoryBot.create(:user,name: "Aran")
        activate @user
        sign_in @user
        @user.follow(@other_user)
      end
      it "200レスポンスを返すこと" do
        get following_user_path(@user)
        expect(response).to have_http_status "200"
      end

      it "followでユーザーをフォローできること" do
        expect(@user.following_user.count).to eq 1
      end

      it "unfollowでユーザーのフォローを解除できること" do
        @user.unfollow(@other_user)
        expect(@user.follower_user.count).to eq 0
      end
    end
  end

end
