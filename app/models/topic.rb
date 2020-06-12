# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user

  validates :sick_name, presence: true, length: { maximum: 30 }
  validates :period, length: { maximum: 20 }
  validates :initial_symptom, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.searching(sick_name)
    Topic.where(['sick_name LIKE ?', "%#{sick_name}%"]) if sick_name
  end

  # csv出力機能
  def self.csv_attributes
    %w[sick_name period initial_symptom content created_at updated_at]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes # 1行目を追加する
      all.find_each do |topic| # 全てのTopicを一行ずつ処理する
        csv << csv_attributes.map { |attr| topic.send(attr) } # attrに属性を入れてsendで中身を取り出す
      end
    end
  end

  # csv入力機能
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row| # 渡されたfileのpassを使ってrowに一行ずつcsvの文字列を入れている
      topic = new # Topicのインスタンスを生成
      topic.attributes = row.to_hash.slice(*csv_attributes) # インスタンスの各属性にcsvの一行を加工して入れる
      topic.save! if topic.valid?
    end
  end
end
