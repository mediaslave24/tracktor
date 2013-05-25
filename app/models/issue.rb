class Issue < ActiveRecord::Base
  attr_accessible :assigned_to, :body, :customer_email, :customer_name, :state, :title
  default_scope order('created_at DESC')

  validates_presence_of :body, :customer_email, :customer_name, :state, :title

  STATES = %w{
    waiting_for_staff
    waiting_for_customer
    onhold
    cancelled
    completed
  }

  before_validation do |record|
    record.state ||= STATES.first
  end

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
