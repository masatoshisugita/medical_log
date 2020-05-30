# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  # before do
  #   @user = FactoryBot.create(:user)
  #   @other_user = FactoryBot.create(:user)
  #   @topic = FactoryBot.create(:topic, user_id: @other_user.id)
  #   activate @user
  #   activate @other_user
  #   sign_in @user
  #   visit topic_path(@topic)
  # end
  # scenario "コメントできること" ,js: true do
  #   fill_in "コメント", with: "がんばりましょう！"
  #   click_button "コメントをする"
  #   expect(page).to have_content "がんばりましょう！"
  # end

  # scenario "コメント削除できること", js: true do
  #   fill_in "コメント", with: "がんばりましょう！"
  #   click_button "コメントをする"
  #   click_link "削除する"
  #   expect(page).not_to have_content "がんばりましょう！"
  # end
end
