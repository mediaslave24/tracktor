class IssueMailer < ActionMailer::Base
  default from: "from@example.com"

  def issue_received(address)
    mail to: address,
         subject: "Your issue has been received, and will be watched soon." 
  end
end
