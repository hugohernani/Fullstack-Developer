class AttachmentPresenter < BasePresenter
  def initialize(storage, view_context:)
    super(storage)
    @view_context = view_context
  end

  def render(_opts = {})
    raise NotImplementedError, 'subclass must implemented it'
  end

  protected

  def renderable?
    object.attached?
  end

  def container_name
    object.name.dasherize << '-container'
  end

  private

  attr_accessor :view_context
end
