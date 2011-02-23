class TestSuitesController < ApplicationController
  
  def show
    @test_suite = end_of_association_chain.current_test_suite
  end
  
private
  def end_of_association_chain
    @project ||= Project.find(params[:project_id])
  end
end