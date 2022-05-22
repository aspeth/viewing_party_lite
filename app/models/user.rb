class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates_presence_of :name
  validates_presence_of :password_digest
  validates :email, uniqueness: true, presence: true

  has_secure_password

  def parties_im_hosting
    Party.all.where(host_id: self.id)
  end
end
