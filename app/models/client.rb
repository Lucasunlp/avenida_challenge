class Client < ApplicationRecord
  before_create :generate_api_key
  has_many :orders
  has_many :products

  validates :email, :full_name, :id_card, :phone, :address, presence: true
  validates :email, uniqueness: { message: 'Already Exists' }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  
  protected

  def generate_api_key
    self.api_key = loop do
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless self.class.exists?(api_key: random_token)
    end
  end
end
