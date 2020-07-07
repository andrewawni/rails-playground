# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :authenticate_user
  before_action :set_todo, only: %i[show update destroy]
  # GET /todos
  def index
    @todos = current_user.todos
    json_response(@todos)
  end

  # POST /todos
  def create
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  # GET /todos/:id
  def show
    json_response(@todo)
  end

  def search
    q = '*'
    q = params[:query] if params[:query].present?
    @todos = Todo.search(q).records.to_a
    json_response(@todos, 200)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    params.require(:todo).permit(:title, :description)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
