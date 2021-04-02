class FactoryStoragePresenter
  class << self
    def for(storage_model, view_context:)
      case storage_model.class.name
      when /Attached::One/
        SingleAttachmentPresenter.new(storage_model, view_context: view_context)
      else
        raise UnknownStorageModelException, "Unknown #{storage_model.class.name} storage"
      end
    end
  end
end

class UnknownStorageModelException < RuntimeError
  def initialize(msg = 'Unknown Storage model', exception_type = self.class)
    @exception_type = exception_type
    super(msg)
  end
end
