class Api::V1::TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @tasks = Task.all
    if @tasks.present?
      render json: @tasks
    else
      render json: {"message": "Henüz bir taskiniz bulunmamaktadır" }
    end
  end

  def show
    begin
      @task = Task.find(params[:id])
      if @task.present?
        render json: {
          id: @task.id,
          name: @task.name,
          description: @task.description,
          is_priority: @task.is_priority,
          created_at: @task.created_at,
          updated_at: @task.updated_at,
          task_category: {
            id: @task.task_category.id,
            name: @task.task_category.name
          }
        }
      end
    rescue
      render json: {"message": "Id numarası #{params[:id]} olan bir task bulunamadı"}
    end
  end

  def create
    @task = Task.new(task_post_params)

    if @task.name.present?
      if TaskCategory.exists?(@task.task_category_id)
        if @task.save
          render json: {
            id: @task.id,
            name: @task.name,
            description: @task.description,
            is_priority: @task.is_priority,
            created_at: @task.created_at,
            updated_at: @task.updated_at,
            task_category: {
              id: @task.task_category.id,
              name: @task.task_category.name
            }
          }
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Geçersiz Task Kategori ID'si." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Görev adı boş geçilemez" }, status: :unprocessable_entity
    end
  end


  def update

    begin
      @task = Task.find(params[:id])
      if @task.update(task_post_params)
        render json: {
            id: @task.id,
            name: @task.name,
            description: @task.description,
            is_priority: @task.is_priority,
            created_at: @task.created_at,
            updated_at: @task.updated_at,
            task_category: {
              id: @task.task_category.id,
              name: @task.task_category.name
            }
          }
      else
        render json: @task.errors, status: :failed
      end
    rescue
      render json: {"message": "Task güncelleme başarısız!!! ID numarası #{params[:id]} olan bir kayıt bulunamadı."}

    end
  end

  def destroy
    begin
      @task = Task.find(params[:id])
      if @task.present?
        @id = @task.id
        @name = @task.name
        @task.destroy
        render json: {"message": "#{@name} adlı task başarıyla silindi", "status": "success"}
      else
        render json: {"message": "Böyle bir task bulunamadı"}
      end
    rescue
      render json: {"message": "Task silme başarısız!!! ID numarası #{params[:id]} olan bir kayıt bulunamadı."}
    end
  end

  private
  def task_post_params
    params.permit(:name, :description, :is_priority,:task_category_id)
  end
end
