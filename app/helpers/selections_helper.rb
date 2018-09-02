module SelectionsHelper
  def select(title)
    Presentation.find_by(Titel: "#{title}")
    flash[:notice] = "Added #{title} to your selection"
  end
end
