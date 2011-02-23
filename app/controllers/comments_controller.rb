class CommentsController < ApplicationController
  
  def index
    @comments = end_of_association_chain.comments
    respond_to do |wants|
      wants.js
    end
  end

  def create
    @comment = end_of_association_chain.comments.create(params[:comment])
    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.js do 
        @comments = end_of_association_chain.comments
        render 'index'
      end
    end
  end

private

  def end_of_association_chain
    @project ||= Project.find(params[:project_id])
    @test    ||= TestDefinition.find(params[:test_id])
  end

end