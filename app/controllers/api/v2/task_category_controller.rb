class Api::V2::TaskCategoryController < ApplicationController
  def index
    @task_categories = TaskCategory.all
    if @task_categories.present?
      render json: @task_categories.as_json(methods: :total_tasks)
    else
      render json: {"message": "Henüz bir task kategorisi oluşturmadınız"}
    end
  end

  def show
    begin
      @task_category = TaskCategory.find params[:id]
      render json: @task_category.as_json(
        include: { tasks: { only: [:id, :name, :description, :is_priority] } },
        methods: :total_tasks  # Toplam görev sayısını ekle
      )
    rescue
      render json: {"message": "#{params[:id]} ID numarasına kayıtlı bir task kategorisi bulunamadı,2"}
    end
  end
end
