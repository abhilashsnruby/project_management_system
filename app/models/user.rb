class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :projects, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.return_error_message(user)
    user.errors.messages.keys[0].to_s + " " + user.errors.messages.values[0].first
  end

  def self.validate_for_error_messages(user)
    user.errors.messages.present? ? 'true' : 'false'
  end

  def self.check_super_user_exists(users,user)
    if users.present?
      user_names = User.pluck(:user_name)
      if (user_names.include?("superuser") || user_names.include?("super_user"))
        super_user = ['superuser', 'super_user']
        sp_user = User.where(user_name: super_user)
        if sp_user.present? && (user.user_name == "superuser" || user.user_name == "super_user")
          return true
        else
          return false
        end
      end
    end
  end

end
