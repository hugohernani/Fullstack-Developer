class SingleAttachmentPresenter < AttachmentPresenter
  def render(opts = {})
    resize_limit = opts.fetch(:resize_and_pad, [600, 400])
    container_css_class = opts.fetch(:container_class, container_name)
    return image_render(resize_limit, container_css_class).html_safe if renderable?
    default_image_placeholder(container_css_class).html_safe
  end

  def image_render(resize_limit, container_class)
    <<~HTML
      <div class="#{container_class}">
        #{view_context.image_tag object.representation(resize_and_pad: resize_limit, gravity: 'north')}
      </div>
    HTML
  end

  def renderable?
    object.attached? && object.representable?
  end
end
