class LanguagesController < ApplicationController
  before_action :find_language, except: [:index, :new, :create]
  before_action :authorize_class

  def index
    @languages = Language.select :id, :name, :image, :description, :creator_id
    @languages.map{|language| language[:image] = {url: language.image.url}}
    @functions = current_user.functions.where controller_name: "languages"
  end

  def new
  end

  def create
    @language = Language.new language_params
    respond_to do |format|
      if @language.save
        format.html{redirect_to @language}
        format.json do
          @language[:image] = {url: @language.image.url}
          render json: {message: flash_message("created"),
            language: @language}
        end
      else
        format.html{render :new}
        format.json do
          render json: {message: flash_message("not_created"),
            errors: @language.errors}, status: :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @language.update_attributes language_params
        format.html{redirect_to @language}
        format.json do
          @language[:image] = {url: @language.image.url}
          render json: {message: flash_message("updated"),
            language: @language}
        end
      else
        format.html{render :edit}
        format.json do
          render json: {message: flash_message("not_updated"),
            errors: @language.errors}, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @language.destroy
    respond_to do |format|
      format.html{redirect_to languages_path}
      format.json do
        if @language.deleted?
          render json: {message: flash_message("deleted")}
        else
          render json: {message: flash_message("not_deleted")},
            status: :unprocessable_entity
        end
      end
    end
  end

  private
  def language_params
    params.require(:language).permit Language::ATTRIBUTE_PARAMS
  end

  def find_language
    @language = Language.find_by id: params[:id]
    unless @language
      respond_to do |format|
        format.html{redirect_to languages_path}
        format.json do
          render json: {message: flash_message("not_found")},
            status: :not_found
        end
      end
    end
  end
end
