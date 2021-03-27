class ObjectService < SmartInit::Base
  is_callable method_name: :perform

  def perform
    raise NotImplementedError, 'subclass must implemented it'
  end
end
