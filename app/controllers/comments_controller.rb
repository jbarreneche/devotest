class CommentsController < ApplicationController
  
  def index
    @comments = end_of_association_chain.comments
    respond_to do |wants|
      wants.js
    end
  end

  def create
    @comment = end_of_association_chain.comments.create(params[:comment])
    redirect_to :back
  end

private
  def end_of_association_chain
    @project    ||= Project.find(params[:project_id])
    @test_suite ||= @project.current_test_suite
    @test       ||= @test_suite.tests.find(params[:test_id])
  end

end