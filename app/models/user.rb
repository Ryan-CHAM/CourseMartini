class User < ApplicationRecord
    before_save {self.email.downcase}

    validates :name, presence: true, length: {in: 2..16}, uniqueness: { case_sensitive: false },format: { without: /\s/ }
    VALID_EMAIL_REGEX =  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, format: {with: VALID_EMAIL_REGEX}, length: {maximum: 30}, uniqueness: { case_sensitive: false }
    has_secure_password 
    validates :password, confirmation: { case_sensitive: true }
end
