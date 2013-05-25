class IssuesController < ActionController::Base
  layout 'main'

  # Actions with views
  def index
    case params[:state]
      when "new_unassigned"
        @issues = Issue.opened.unassigned
      when "opened"
        @issued = Issue.opened.all
      when "onhold"
        @issues = Issue.onhold.all
      when "closed"
        @issues = Issue.closed.all
      else
        @issues = Issue.all
    end
    @issues ||= []
  end

  def new
    @issue = Issue.new
  end

  def search
    @issues = Issue.search(params[:query])
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  # Actions without views
  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      IssueMailer.issue_received(@issue.customer_email).deliver
      redirect_to @issue
    else
      render :new
    end
  end

  def delete
    @issue = Issue.find(params[:id])
  end

  def change
    @issue = Issue.find(params[:id])
    if @issue.save
      redirect_to @issue
    else
      render :edit
    end
  end
end
