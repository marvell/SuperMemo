module ApplicationHelper
  def nav_link(link_text, link_path, class_name = 'active')
    class_name = '' if not current_page?(link_path)

    link_to link_text, link_path, class: class_name
  end
end
