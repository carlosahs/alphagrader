# frozen_string_literal: true
class AssignmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource through: :course

  def page_title
    'Assignments'
  end

  def show
    @submissions = @assignment.submissions
                              .accessible_by(current_ability)
                              .order('submissions.created_at desc')
    @assignment = @assignment.decorate
  end

  def new
  end

  def edit
  end

  def create
    if @assignment.update_attributes(assignment_params)
      redirect_to [@course, @assignment]
    else
      render 'edit'
    end
  end

  def update
    if @assignment.update_attributes(assignment_params)
      redirect_to [@course, @assignment]
    else
      render 'edit'
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :due_date, :description)
  end
end
