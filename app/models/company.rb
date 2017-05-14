class Company < ActiveRecord::Base
  has_secure_password

  has_many :topics,   dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username,   presence:   true,
                         uniqueness: { case_sensitive: false },
                         length:     { in: 4..12 },
                         format:     { with: /\A[a-zA-Z][a-zA-Z0-9_-]*\Z/ }
  validates :company_name, presence:   true
  validates :company_email,      presence:   true,
                         uniqueness: { case_sensitive: false },
                         email:      true

  def to_param
   username
  end

  def avatar_url(size = 160)
    hash_value = Digest::MD5.hexdigest(company_email.downcase)
    "http://www.gravatar.com/avatar/#{hash_value}?s=#{size}"
  end
end
