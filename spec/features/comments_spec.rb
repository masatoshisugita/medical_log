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
end
