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
      csv << csv_attributes
      all.find_each do |topic|
        csv << csv_attributes.map { |attr| topic.send(attr) }
      end
    end
  end

  # csv入力機能
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      topic = new
      topic.attributes = row.to_hash.slice(*csv_attributes)
      topic.save! if topic.valid?
    end
  end
end
