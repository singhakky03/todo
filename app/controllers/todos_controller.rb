class TodosController < ApplicationController

  before_filter:authenticate_user!, :except=>[:show, :index]
 
  def index
    @todo = Todo.new
    @todos = Todo.order("todo_item").paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @todo_items=Todo.find(params[:id])
  end

   def destroy
    @todo_items  = Todo.find(params[:id])
    @todo_items.destroy
    redirect_to todos_path
  end

  def create
    todo = Todo.create(:todo_item=>params[:todo][:todo_item])
    if !todo.valid?
        flash[:error]=todo.errors.full_messages.join("<br>").html_safe
      else
       flash[:success]="Todo Added Successfully"
    end
    redirect_to :action=> 'index'
  end

  def complete
    params[:todos_checkbox].each do |check|
      todo_id=check
      t=Todo.find_by_id(todo_id)
      t.update_attribute(:completed, true)
    end
    redirect_to :action=>'index'
  end

  def edit
    @todo_items=Todo.find(params[:id])
  end

  def update
    @todo_items=Todo.find(params[:id])

    if @todo_items.update_attributes(params[:todo])
      redirect_to @todo_items, notice:"Todo was updated Successfully"
    else
      render :action=>'edit'
    end
  end

end
