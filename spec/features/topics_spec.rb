# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Topics', type: :feature do
  describe 'topicの登録、編集、削除' do
    before do
      @user = FactoryBot.create(:user)
      activate @user
      sign_in @user
    end

    scenario '有効な値ならユーザーは投稿できること' do
      visit new_topic_path
      fill_in '病気の名前', with: '高熱'
      fill_in '期間', with: '1日から2日'
      fill_in '初期症状', with: '鼻水、喉の痛み、節々の痛み'
      fill_in '内容', with: '医者に行ったらただの風邪でした。薬を飲んだら治りました！'
      expect { click_button '登録する' }.to change { Topic.count }.by(1)
      expect(page).to have_content '「高熱」を登録しました。'
    end

    scenario '無効な値ならユーザーは投稿できないこと' do
      visit new_topic_path
      fill_in '病気の名前', with: nil
      fill_in '期間', with: '1日から2日'
      fill_in '初期症状', with: '鼻水、喉の痛み、節々の痛み'
      fill_in '内容', with: '医者に行ったらただの風邪でした。薬を飲んだら治りました！'
      expect { click_button '登録する' }.not_to change { Topic.count }
      expect(page).to have_content '有効な値を入力してください。'
    end

    scenario '自分が投稿したtopicなら編集できること' do
      topic = FactoryBot.create(:topic, user_id: @user.id)
      visit topic_path(topic)
      click_link '編集'
      fill_in '病気の名前', with: '軽い骨折'
      click_button '編集する'
      expect(page).to have_content 'トピックを更新しました。'
    end

    scenario '自分が投稿したtopicなら削除できること' do
      topic = FactoryBot.create(:topic, user_id: @user.id)
      visit topic_path(topic)
      expect { click_link '削除' }.to change { Topic.count }.by(-1)
      expect(page).to have_content '「風邪」を削除しました。'
    end
  end

  describe '検索機能' do
    before do
      @user = FactoryBot.create(:user)
      @topic = FactoryBot.create(:topic, user_id: @user.id)
      activate @user
      sign_in @user
      visit root_path
    end
    scenario '投稿しているsick_nameを検索されると、そのsick_nameが表示されること' do
      fill_in 'search', with: '風邪'
      click_button '検索'
      expect(page).to have_content '「風邪」の検索結果'
    end

    scenario '投稿していないsick_nameを検索されると、エラーがでること' do
      fill_in 'search', with: '軽めの腹痛'
      click_button '検索'
      expect(page).to have_content '「軽めの腹痛」に一致する病名は現在ありません'
    end

    scenario 'フォームが空の場合、エラーがでること' do
      fill_in 'search', with: ''
      click_button '検索'
      expect(page).to have_content '病気の名前を入力してください。'
    end
  end
end
