require 'rails_helper'

describe 'get all quotes route', :type => :request do
  let!(:quotes) { FactoryBot.create_list(:quote, 20) }

  before { get '/quotes' }

  # Tests for correct body size
  it 'returns all quotes' do
    expect(JSON.parse(response.body).size).to eq(20)
  end

  # Tests for correct header status
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

end

# Test Name Search Parameter - Good Search
describe 'get all quotes route matching a name search', :type => :request do
  let!(:quotes) { FactoryBot.create(:quote, author:'Jane Austen', content: "If I loved you less, I might be able to talk about it more." ) }

  before do
    get '/quotes', params: {name: 'Austen'} 
  end 

  # Tests for correct body size
  it 'returns all quotes that match serach' do
    expect(JSON.parse(response.body).size).to eq(1)
  end

  # Tests for correct header
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  # Tests for correct body content
  it 'returns correct content' do
    expect(JSON.parse(response.body)[0]['author']).to eq('Jane Austen')
  end

  it 'returns correct content' do
    expect(JSON.parse(response.body)[0]['content']).to eq("If I loved you less, I might be able to talk about it more.")
  end

end

# Test Name Search Parameter - Bad Search
describe 'get all quotes route matching a name search', :type => :request do
  let!(:quotes) { FactoryBot.create(:quote, author:'Jane Austen', content: "If I loved you less, I might be able to talk about it more." ) }

  before do
    get '/quotes', params: {name: 'Smith'} 
  end 

  # Tests for correct body size
  it 'returns all quotes that match search' do
    expect(JSON.parse(response.body).size).to eq(0)
  end

  # Tests for correct header
  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  # Tests for correct body content
  it 'returns correct content' do
    expect(JSON.parse(response.body)).to eq([])
  end

end