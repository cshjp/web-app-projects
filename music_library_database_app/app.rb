# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums/new' do
    return erb(:new_albums)
  end

  post '/albums/created' do
    @title = params[:album_title]
    @release_year = params[:album_release_year]
    @artist_id = params[:album_artist_id]
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = @title
    new_album.release_year = @release_year
    new_album.artist_id = @artist_id
    repo.create(new_album)
    return erb(:created_albums)
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/albums/' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get '/artists/' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:new_artists)
  end

  post '/artists/created' do
    @name = params[:artist_name]
    @genre = params[:artist_genre]
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = @name
    new_artist.genre = @genre
    repo.create(new_artist)
    return erb(:created_artists)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new

    @artist = repo.find(params[:id])

    return erb(:artist)
  end
end