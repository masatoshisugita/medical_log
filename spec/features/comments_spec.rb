# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @topic = FactoryBot.create(:topic, user_id: @other_user.id)
    activate @user
    activate @other_user
    visit root_path
    sign_in @user
    visit topic_path(@topic)
  end

  scenario 'コメントボタンがあること' do
    expect(page).to have_button 'コメントをする'
  end

  scenario '有効な値なら、コメントできること', js: true do
    fill_in 'コメント', with: '自分も同じ経験をしました！お互い頑張りましょう。'
    click_button 'コメントをする'
    sleep 1
    expect(Comment.count).to eq 1
  end

  scenario '値が空なら,コメントできないこと', js: true do
    fill_in 'コメント', with: ''
    click_button 'コメントをする'
    expect(page).not_to have_content '自分も同じ経験をしました！お互い頑張りましょう。'
  end

  scenario '値が151文字以上なら,コメントできないこと', js: true do
    fill_in 'コメント', with: 'あ' * 151
    click_button 'コメントをする'
    expect(page).not_to have_content 'あ' * 151
  end

  scenario '同じユーザーなら,コメント削除できること', js: true do
    comment = FactoryBot.create(:comment,user_id: @user.id,topic_id: @topic.id)
    visit topic_path(@topic)
    click_button '削除する'
    expect(page).not_to have_content '自分も同じ経験をしました！お互い頑張りましょう。'
  end

  scenario '違うユーザーなら、コメント削除できないこと' do
    comment = FactoryBot.create(:comment, user_id: @other_user.id)
    visit topic_path(@topic)
    expect(page).not_to have_link '削除する'
  end
end
