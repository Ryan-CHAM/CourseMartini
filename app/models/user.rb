class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    before_save {self.email.downcase}
    # Validates user name's length; only allow alphabets and numbers
    validates :name, length: {in: 2..16}, uniqueness: { case_sensitive: false },format: { with: /\A[a-zA-Z0-9]+\Z/ }
    # Validates email format, e.g: xxx@yyy.zz
    VALID_EMAIL_REGEX =  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, format: {with: VALID_EMAIL_REGEX}, length: {maximum: 30}
    # Validates if password confirmation is same as password
    validate :password_confirmation_matches_password
    def password_confirmation_matches_password
      if password != password_confirmation
      end
    end
    
  has_many :comments
	has_many :courses, through: :comments

end
