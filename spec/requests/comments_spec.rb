# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, name: '山田　三郎')
    @topic = FactoryBot.create(:topic, user_id: @user.id)
    activate @user
    activate @other_user
  end

  describe '#create' do
    before do
      sign_in @other_user
    end

    context '有効な値の時' do
      it 'コメントできること' do
        comment_params = FactoryBot.attributes_for(:comment)
        expect { post topic_comments_path(topic_id: @topic.id, comment: comment_params), xhr: true }.to change { Comment.count }.by(1)
      end
    end

    context '無効な値の時' do
      it 'コメントが空の時、コメントできないこと' do
        comment_params = FactoryBot.attributes_for(:comment, review: '')
        expect { post topic_comments_path(topic_id: @topic.id, comment: comment_params), xhr: true }.not_to change { Comment.count }
      end
      it 'コメントが151文字以上の時、コメントできないこと' do
        comment_params = FactoryBot.attributes_for(:comment, review: 'a' * 151)
        expect { post topic_comments_path(topic_id: @topic.id, comment: comment_params), xhr: true }.not_to change { Comment.count }
      end
    end
  end

  describe '#destroy' do
    it 'コメントしたユーザーなら、コメント削除できること' do
      @comment = FactoryBot.create(:comment, user_id: @other_user.id)
      sign_in @other_user
      expect { delete topic_comment_path(@topic.id, @comment.id), xhr: true }.to change { Comment.count }.by(-1)
    end

    it 'コメントしたユーザーではないなら、コメント削除できないこと' do
      @comment = FactoryBot.create(:comment, user_id: @user.id)
      sign_in @other_user
      expect { delete topic_comment_path(@topic.id, @comment.id), xhr: true }.not_to change { Comment.count }
    end

    it 'ログインしていないユーザーなら、コメント削除できないこと' do
      @comment = FactoryBot.create(:comment, user_id: @other_user.id)
      expect { delete topic_comment_path(@comment.topic_id, @comment.id), xhr: true }.not_to change { Comment.count }
    end
  end
end
