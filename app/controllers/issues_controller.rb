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

  def reply_form
    @comment = Issue.find(params[:id]).new
  end

  # Actions without views
  def reply
    @comment = Issue.find(params[:id]).new(params[:comment])
    @comment.author = current_user
    if @comment.save
      redirect_to @comment.issue
    else
      render :reply_form, error: "Something went wrong"
    end
  end
  def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      IssueMailer.issue_received(@issue.customer_email).deliver
      redirect_to @issue, notice: "Issue has been created successfully"
    else
      render :new, error: "Something went wrong"
    end
  end

  def delete
    @issue = Issue.find(params[:id]).delete
    redirect_to root_path, notice: "Issue has been deleted"
  end

  def change
    @issue = Issue.find(params[:id])
    if @issue.save
      redirect_to @issue, notice: "Issue has been updated"
    else
      render :edit, error: "Something went wrong"
    end
  end
end
