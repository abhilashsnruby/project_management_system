class RoleRouteConstraint
  def initialize(&block)
    @block = block || lambda { |user| true }
  end

  def matches?(request)
    binding.pry
    user = current_user(request)
    user.present? && @block.call(user)
  end

  def current_user(request)
    binding.pry
    User.find_by_id(request.session[:user_id])
  end
end