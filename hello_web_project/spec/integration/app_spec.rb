require "spec_helper"
require_relative "../../app.rb"
require "rack/test"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /names" do
    it 'returns Julia, Mary, Karim' do
      # Assuming the post with id 1 exists.
      response = get('/names')

      expect(response.body).to eq('Julia, Mary, Karim')
    end
  end

  context "GET /hello" do
    xit 'returns hello name' do
      response = get('/hello?name=Leo')

      expect(response.body).to eq('Hello Leo')
    end

    it 'returns hello and includes erb code' do
      response = get('/hello')

      expect(response.body).to include('<h1>Hello!</h1>')
    end
  end
  
  context "POST /sort-names" do
    it 'returns names sorted alphabetically' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.body).to eq('Alice,Joe,Julia,Kieran,Zoe')
    end
  end
end