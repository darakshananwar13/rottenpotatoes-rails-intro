class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings=Movie.uniq.pluck(:rating)
    
    column = params[:column]
    
    if(!column and session[:column])
      column = session[:column]
    else  
      column ||='release_date'
    end
    session[:column] = column
    
    @checkbox = params[:ratings]
    
    if(@checkbox)
      @checkbox_selected = @checkbox.keys
    end
    
    if(!@checkbox and session[:ratings] )
      @checkbox = session[:ratings]
      @checkbox_selected = session[:ratings].keys
    else  
      @checkbox_selected||=@all_ratings
    end
    
    session[:ratings] = @checkbox
    @movies = Movie.where(rating: @checkbox_selected).order(column)
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
