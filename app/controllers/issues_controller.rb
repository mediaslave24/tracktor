class IssuesController < ActionController::Base
  before_filter :authenticate_manager!, only: [:edit, :delete, :change, :reply]
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
    render :index
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      IssueMailer.issue_received(@issue.customer_email).deliver
      redirect_to @issue, notice: "Issue has been created successfully"
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def delete
    @issue = Issue.find(params[:id]).delete
    redirect_to root_path, notice: "Issue has been deleted"
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(params[:issue])
      if params[:comment]
        comment = @issue.comments.new(params[:comment])
        comment.author = current_manager
        comment.save
      end
      IssueMailer.issue_updated(@issue.customer_email, url_for(@issue)).deliver
      redirect_to @issue, notice: "Issue has been updated"
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end
end
