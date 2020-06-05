# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             user_image: nil,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
name  = "#{n}test name"
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
                email: email,
                user_image: nil,
                password:              password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

10.times do |n|
    User.all.each do |user|
        user.topics.create!(
            sick_name: "test#{n}",
            period: "#{n}日",
            initial_symptom: "#{n}回咳が出ました",
            content: "#{n}回目の内容です"
        )
    end
end
users = User.all
user = users.first
following_user = users[2..50]
follower_user = users[3..40]
following_user.each{ |followed| user.follow(followed) }
follower_user.each{ |follower| follower.follow(user) }
