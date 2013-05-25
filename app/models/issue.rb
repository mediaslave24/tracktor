class Issue < ActiveRecord::Base
  attr_accessible :assigned_to, :body, :customer_email, :customer_name, :state, :title
  default_scope order('created_at DESC')

  def assigned_to
    assignee = Object.new
    def assignee.name
      "joe"
    end
    assignee
  end

  def search
    []
  end
end
