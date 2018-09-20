module SessionsHelper
  # Sets session details for Admin login
  def log_in(admin)
    session[:admin_id] = admin.id
  end
  # Sets session details for Student login
  def stud_in(student)
    session[:student_id] = student.id
  end
  # Logs out admin user
  def log_out
    session.delete(:admin_id)
    @current_admin = nil
  end
  # Logs student out
  def stud_out
    session.delete(:student_id)
    @current_student = nil
  end
  # Called when user confirms their selection
  def studsend
    flash[:success] = "Anmeldung verschickt!"
    stud_out
    return
  end
  # Method to find out if current session is an Admin session, and which admins is logged in
  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end
  end
  # Method to find out if current session is a student session, and which student is logged in
  def current_student
    if session[:student_id]
      @current_student ||= Schueler.find_by(id: session[:student_id])
    end
  end
  # Checks to see if logged in as an admin
  def logged_ad?
    !current_admin.nil?
  end
  # Checks to see if logged in as student
  def logged_stud?
    !current_student.nil?
  end
end
