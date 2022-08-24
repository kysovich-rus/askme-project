module ApplicationHelper
  def inclination(amount, form1, form2, form_many)
    if (amount % 100).between?(11, 14) then return form_many
    elsif (amount % 10).between?(2, 4) then return form2
    elsif amount % 10 == 1             then return form1
    end
    return form_many
  end
end
