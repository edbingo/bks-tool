module SessionsHelper
  # Sets session details for Admin login
  def log_in(admin)
    session[:admin_id] = admin.id
  end
  # Sets session details for Student login
  def stud_in(student)
    session[:student_id] = student.id
  end

  def log_out
    session.delete(:admin_id)
    @current_admin = nil
  end

  def stud_out
    session.delete(:student_id)
    @current_student = nil
  end

  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end
  end

  def current_student
    if session[:student_id]
      @current_student ||= Schueler.find_by(id: session[:student_id])
    end
  end

  def logged_ad?
    !current_admin.nil?
  end

  def logged_stud?
    !current_student.nil?
  end
end
