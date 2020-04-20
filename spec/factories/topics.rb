FactoryBot.define do
  factory :topic do
    sick_name "風邪"
    period "2日間程"
    initial_symptom "鼻水、喉の痛み、頭痛"
    content "熱は37℃後半でした。医者からもらった薬を飲んで安静にしていたら治りました。みなさんも気をつけてください"
    association :user
    
  end
end
