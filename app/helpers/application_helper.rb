module ApplicationHelper
  def art(locale_identifier)
    I18n.t(locale_identifier, scope: %i[activerecord attributes]).titleize
  end

  def storage_presenter(storage_model)
    FactoryStoragePresenter.for(storage_model, view_context: self)
  end
end
