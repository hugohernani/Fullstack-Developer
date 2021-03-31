class SingleAttachmentPresenter < AttachmentPresenter
  def render(opts = {})
    resize_limit = opts.fetch(:resize, [385, 230])
    return image_render(resize_limit).html_safe if renderable?
  end

  def image_render(resize_limit)
    <<~HTML
      <div class="#{container_name}">
        #{view_context.image_tag object.representation(resize_to_limit: resize_limit)}
      </div>
    HTML
  end

  def renderable?
    object.attached? && object.representable?
  end
end
