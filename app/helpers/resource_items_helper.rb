module ResourceItemsHelper
  def gravatar_helper user
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", class: 'img-fluid'
  end

  def resource_item_status_color resource_item
    'color: #d9534f;' if resource_item.draft?
  end

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      if code and language
        CodeRay.scan(code, language).div
      end
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(escape_html: true, hard_wrap: true, with_toc_data: true)

    options = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true,
      lax_html_blocks: true,
      with_toc_data: true

    }

    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)

    markdown_to_html.render(text).html_safe
  end
end
