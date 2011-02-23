class TestsController < ApplicationController
  def show
    @test = TestDefinition.find(params[:id])
  end
  
end