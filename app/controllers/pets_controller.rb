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
    @owner.update(params["owner"])
    if !params["owner_name"].empty?
        @owner = Owner.create(name: params["owner_name"])
        @pet.owner = @owner
        @pet.update(params[:pets])
    else
        @owner = Owner.find_by(id: params[:owner_id])
    end

    redirect "/pets/#{@pet.id}"
  end
end
