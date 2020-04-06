class Relationship < ApplicationRecord
  # フォローする人は「follower」、フォローされる人は「followed」
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
