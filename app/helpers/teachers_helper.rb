module TeachersHelper
  def sort_link(col, title = nil )
    title ||= col.titleize
    dir = col == sort_col && sort_dir == "asc" ? "desc" : "asc"
    icon = sort_dir == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
    icon = col == sort_col ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, { col: col, dir: dir }
  end
end
