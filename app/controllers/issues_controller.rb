class IssuesController < ActionController::Base
  layout 'main'

  # Actions with views
  def index
    @issues = Issue.all
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
