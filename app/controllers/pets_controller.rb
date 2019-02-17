class PetsController < ApplicationController

  get '/pets' do
    @owners = Owner.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner_name"].empty?
        @owner = Owner.create(name: params["owner_name"])
        @pet.owner = @owner
        @pet.save
    end
    redirect "/pets/#{@pet.id}"
  end

  get "/pets/:id/edit" do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
        @owner = Owner.create(name: params[:owner][:name])
    else
        @owner = Owner.find_by(id: params[:pet][:owner_id])
    end
    binding.pry
    @pet.owner.id = @owner.id
    @pet.update(params[:p])
    @pet.save

    redirect "/pets/#{@pet.id}"
  end
end
