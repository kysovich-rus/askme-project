module UsersHelper
  def link_name(user)
    "@#{user&.nickname}"
  end
end
