# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  enum role: %i[user user_restaurant user_brand admin]
  after_initialize :set_default_role, if: :new_record?

  belongs_to :restaurant

  def set_default_role
    self.role ||= :user
  end
end
