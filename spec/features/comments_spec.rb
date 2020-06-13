# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @topic = FactoryBot.create(:topic, user_id: @other_user.id)
    activate @user
    activate @other_user
    sign_in @user
    visit topic_path(@topic)
  end

  scenario 'コメントボタンがあること' do
    expect(page).to have_button 'コメントをする'
  end

  # scenario '有効な値なら、コメントできること',js: true do
  #   fill_in 'コメント', with: '自分も同じ経験をしました！お互い頑張りましょう。'
  #   click_button 'コメントをする'

  #   expect(page).to have_content '自分も同じ経験をしました！お互い頑張りましょう。'
  # end
end
