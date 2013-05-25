class Issue < ActiveRecord::Base
  attr_accessible :assigned_to, :body, :customer_email, :customer_name, :state, :title
  default_scope order('created_at DESC')

  # scope :unassigned, ->{ where(assigned_to: nil) }
  # scope :onhold,     ->{ where(state: "onhold") }
  # scope :opened,     ->{ where(state: %w{ onhold waiting_for_staff waiting_for_customer }) }
  scope :closed,     ->{ where(state: %w{ cancelled completed }) }

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
    def assignee.to_s
      "joe"
    end
    assignee
  end

  def search
    []
  end
end
