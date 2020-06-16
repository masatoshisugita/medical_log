# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @topic = FactoryBot.create(:topic, user_id: @other_user.id, sick_name: '右手の打撲')
    activate @user
    activate @other_user
    sign_in @user
    visit topic_path(@topic)
  end

  scenario 'いいねボタンがあること' do
    expect(page).to have_selector '.not_like_link'
  end

  scenario 'いいねするとボタンが切り替わること', js: true do
    like = FactoryBot.create(:like,user_id: @user.id,topic_id: @topic.id)
    visit topic_path(@topic)
    #find('.not_like_link').find('.fa-heart').click
    expect(page).to have_selector '.like_link'
  end

  # scenario 'いいねを2回するともとに戻ること', js: true do
  #   like = Like.FactoryBot.create(:like,user_id: @user.id,topic_id: @topic.id)
  #   find('.like_link').find('.fa-heart').click
  #   expect(page).to have_selector '.not_like_link'
  # end

  scenario 'いいねすると、いいね一覧に表示されること', js: true do
    find('.not_like_link').find('.fa-heart').click
    visit "/likes/#{@user.id}/index"
    expect(page).to have_content '右手の打撲'
  end
end
