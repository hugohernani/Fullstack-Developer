module ApplicationHelper
  def art(locale_identifier)
    I18n.t(locale_identifier, scope: %i[activerecord attributes]).titleize
  end
end
