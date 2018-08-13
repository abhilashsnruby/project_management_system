class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :projects, dependent: :destroy
  belongs_to :employee

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 10..128

  scope :find_all_super_users, -> { joins(:roles).where("roles.name = ?", 'superuser' ) }

  scope :find_all_moderators, -> { joins(:roles).where("roles.name = ?", 'moderator' ) }

  # before_save :check_super_user_exists?, User.User.where(user_name: super_user).present?

  def self.retrive_complete_user_details
    @users = User.all
    @employees = Employee.all
    @projects = Project.all
    [@users, @employees, @projects]
  end

  def self.retrive_users_data(params)
    users_ids = User.pluck(:id)
    if users_ids.count > params['index'].to_i
      User.where(id: users_ids[users_ids[3] .. User.count])
    else
      User.all
    end
  end

  def self.extract_uique_users_with_role
    if User.present?
      mod_sup_or = (User.find_all_moderators.pluck(:id) | User.find_all_super_users.pluck(:id))
      mod_sup_ad = (User.find_all_moderators.pluck(:id) & User.find_all_super_users.pluck(:id))
      (mod_sup_or - mod_sup_ad)
    end
  end

  def find_user_role(user)
    user.has_role?('superuser') ||
    user.has_role?('super_user') ||
    user.has_role?('admin')
  end

  def self.return_error_message(user)
    user.errors.messages.keys[0].to_s + " " + user.errors.messages.values[0].first
  end

  def self.validate_for_error_messages(user)
    user.errors.messages.present? ? 'true' : 'false'
  end

  def self.assign_roles_to_user(params, user)
    if params['user_role'].present?
      ActionController::Parameters.permit_all_parameters = true
      user_roles = params['user_role']['role'][0].values
      user_roles.each { |role| user.add_role(role) }
    end
  end
  
  def self.retrive_employees
    (Employee.count > 0) ? Employee.all.pluck(:empname) : ''
  end

  # def self.check_super_user_exists(users, user)
  #   if users.present?
  #     user_names = User.pluck(:user_name)
  #     if (user_names.include?("superuser") || user_names.include?("super_user"))
  #       super_user = ['superuser', 'super_user']
  #       sp_user = User.where(user_name: super_user)
  #       if sp_user.present? && (user.user_name == "superuser" || user.user_name == "super_user")
  #         return true
  #       else
  #         return false
  #       end
  #     else
  #       return false
  #     end
  #   end
  # end
end