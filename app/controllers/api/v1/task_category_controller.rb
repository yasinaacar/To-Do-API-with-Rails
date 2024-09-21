class Api::V1::TaskCategoryController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @task_categories = TaskCategory.all
    if @task_categories.present?
      render json: @task_categories
    else
      render json: {"message": "Henüz bir task kategorisi oluşturmadınız"}
    end
  end

  def show
    begin
      @task_category = TaskCategory.find params[:id]
      render json: @task_category
    rescue
      render json: {"message": "#{params[:id]} ID numarasına kayıtlı bir task kategorisi bulunamadı"}
    end
  end

  def create
    begin
      @task_category = TaskCategory.new(task_category_params)
      if TaskCategory.where(name: @task_category.name).present?
        render json: {"message": "#{@task_category.name} adlı bir task kategorisi zaten var"}
      else
        if (@task_category.name.present? and @task_category.name.strip != "") and @task_category.save
          render json: @task_category
        else
          render json: {"message": "Task kategori adı boş geçilemez"}
        end
      end
    rescue
      render json: {"message": "Yeni task kategorisi oluşturulurken hata meydana geldi"}
    end
  end

  def update
    begin
      @task_category = TaskCategory.find(params[:id])
      if (@task_category.name.present? and @task_category.name.strip != "") and @task_category.update(task_category_params)
        render json: @task_category
      else
        render json: {"message": "Task kategorisi adı boş geçilemez"}
      end
    rescue
      render json: {"message": "Böyle bir task kategorisi bulunamadı"}
    end
  end

  def destroy
    begin
      @task_category = TaskCategory.find(params[:id])
      @id = @task_category.id
      @name = @task_category.name
      @task_category.destroy
      render json: {"message": "#{@name} adlı task kategorisi başarıyla silindi", "status": "success"}
    rescue
      render json: {"message": "Böyle bir task kategorisi bulunamadı"}
    end
  end

  private
  def task_category_params
    params.permit(:name)
  end
end
