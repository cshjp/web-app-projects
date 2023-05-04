require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    reset_tables
  end

  context "GET /albums/:id" do
    it 'returns first album when /1' do
      response = get('/albums/1')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include(
      '<p>Release Year: 1989 Artist: Pixies</p>'
      )
    end
  end

  context "GET /albums" do
    it 'returns a list of albums' do
      response = get('/albums')


      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')

    end
  end

  context "GET /artists" do
    it 'returns a list of artists' do
      response = get('/artists')


      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/2">ABBA</a>')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')

    end
  end

  context "GET /artists/:id" do
    it 'returns first artist when /2' do
      response = get('/artists/2')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include(
      '<p>Genre: Pop</p>'
      )
    end
  end
end
