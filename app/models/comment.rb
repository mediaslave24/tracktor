class Comment < ActiveRecord::Base
  attr_accessible :body
  validates_presence_of :author_id, :issue_id
  belongs_to :issue
  belongs_to :author, class_name: "Manager", foreign_key: "author_id"
end
