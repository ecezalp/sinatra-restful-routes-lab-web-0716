
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
 
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    @single_recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @single_recipe.save
    redirect "/recipes/#{@single_recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @single_recipe = Recipe.find(params[:id])
    erb :show
    # redirect '/recipes'
  end

  get '/recipes/:id/edit' do
    @to_be_edited = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do 
    @single_recipe = Post.find(params[:id])
    @single_recipe.name = params[:name]
    @single_recipe.ingredients = params[:ingredients]
    @single_recipe.cook_time = params[:cook_time]
    @single_recipe.save
    erb :show
  end

  delete '/recipes/:id/delete' do
    @single_recipe = Recipe.find(params[:id])
    @single_recipe.destroy
    @recipes = Recipe.all
    erb :index
  end

end