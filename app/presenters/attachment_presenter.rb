class AttachmentPresenter < BasePresenter
  def initialize(storage, view_context:)
    super(storage)
    @view_context = view_context
  end

  def render(_opts = {})
    raise NotImplementedError, 'subclass must implemented it'
  end

  protected

  def default_image_placeholder(container_class)
    <<~HTML
      <div class="#{container_class}">
        #{view_context.image_tag placeholder_image_url, loading: 'lazy'}
      </div>
    HTML
  end

  def renderable?
    object.attached?
  end

  def container_name
    object.name.dasherize << '-container'
  end

  private

  attr_accessor :view_context

  def placeholder_image_url
    placeholder_text = 'Add an image'
    "https://via.placeholder.com/300/FFFFFF/0000FF?text=#{placeholder_text}"
  end
end
