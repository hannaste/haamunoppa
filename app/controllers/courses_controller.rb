class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :getAverage]
  before_action :authenticate_user!, except: [:index, :show]
  helper_method :sort_column, :sort_direction

  def search 
    if params[:search].present?
      @courses = Course.search(params[:search])
    else
      @courses = Course.all
    end
  end

  # GET /courses
  # GET /courses.json
  def index
    params[:sort] ||= "name"
    @courses = Course.order(sort_column + " " + sort_direction)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @reviews = Review.where(course_id: @course.id).order("created_at DESC")
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  # GET /courses/new
  def new
    # Creates the connection between the user and the course
    @course = current_user.courses.build
  end

  # GET /courses/1/edit
  def edit
  end


  def getAverage 
    @reviews = Review.where(course_id: @course.id).order("created_at DESC")
    @avg_review
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.build(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Uusi kurssi luotiin.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Kurssin tiedot päivitettiin.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Kurssi poistettiin.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :code, :description, :credits, :period, :department, :rating)
    end

  private
  
  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
