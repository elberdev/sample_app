class Micropost < ActiveRecord::Base
  belongs_to :user
  # the default scope sets the order in which entries will be pulled from the
  # database. In this case it's most recent to older
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
