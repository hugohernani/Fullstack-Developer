module ApplicationHelper
  def art(locale_identifier)
    I18n.t(locale_identifier, scope: %i[activerecord attributes]).titleize
  end

  def storage_presenter(storage_model)
    FactoryStoragePresenter.for(storage_model, view_context: self)
  end

  def error_message_for(model, field, opts = {})
    return error_for(model, field) if model.errors.any?

    model_klass = opts.fetch(:model_klass, model.class)
    new_instance = model_klass.new
    !new_instance.valid? && error_for(new_instance, field)
  end

  def error_for(model, field)
    model.errors.messages_for(field).to_exclusive_sentence
  end
end
