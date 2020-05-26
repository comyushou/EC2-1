class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :orders
  has_many :cart_items

  def active_for_authentication?
    super && self.is_active
  end

  validates :family_name,:first_name,:kana_family_name,:kana_first_name,:postal_code,:address,:phone_number, presence: true

# ログインする時に退会済み(is_active==false)のユーザーを弾くためのメソッド
	

end


