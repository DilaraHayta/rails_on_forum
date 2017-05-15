class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  belongs_to :topic, counter_cache: true

  validates :user,  presence: true
  validates :topic, presence: true
end
