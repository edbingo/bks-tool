module Resetable
  extend ActiveSupport::Concern
  class_methods do
    def truncate!
      self.connection.execute(
        "Delete from #{ self.table_name };"
      )
    end
  end
end
