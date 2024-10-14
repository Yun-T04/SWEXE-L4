require 'bcrypt'

class User < ApplicationRecord
  # BCryptでパスワードをハッシュ化するメソッド
  def password=(new_password)
    self.pass = BCrypt::Password.create(new_password)
  end

  # パスワード認証のメソッド
  def authenticate(input_password)
    BCrypt::Password.new(self.pass) == input_password
  end
end
