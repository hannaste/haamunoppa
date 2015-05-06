class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Creating enums for role-based authorization
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
 
  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses
  has_many :reviews, dependent: :destroy
end
