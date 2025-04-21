require 'rails_helper'

RSpec.describe 'GraphQL API', type: :request do
  let!(:user) do
    User.create!(
      first_name: 'Jane',
      last_name: 'Doe',
      email: 'jane@example.com'
    )
  end

  let!(:blog) do
    Blog.create!(
      title: 'My First Blog',
      description: 'Intro post!',
      user: user
    )
  end

  describe 'users query' do
    let(:query) do
      <<~GQL
        query {
          users {
            id
            firstName
            lastName
            email
            userName
            blogs {
              title
              description
            }
          }
        }
      GQL
    end

    it 'returns all users with blogs and userName' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['users'].first

      expect(data['email']).to eq(user.email)
      expect(data['userName']).to eq("#{user.first_name} #{user.last_name}")
      expect(data['blogs'].first['title']).to eq(blog.title)
    end
  end

  describe 'blogs query' do
    let(:query) do
      <<~GQL
        query {
          blogs {
            id
            title
            description
            user {
              id
              userName
            }
          }
        }
      GQL
    end

    it 'returns all blogs with their user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['blogs'].first

      expect(data['title']).to eq(blog.title)
      expect(data['user']['userName']).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe 'single user query' do
    let(:query) do
      <<~GQL
        query {
          user(id: #{user.id}) {
            email
            userName
          }
        }
      GQL
    end

    it 'returns a specific user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']

      expect(data['email']).to eq(user.email)
      expect(data['userName']).to eq("Jane Doe")
    end
  end

  describe 'single blog query' do
    let(:query) do
      <<~GQL
        query {
          blog(id: #{blog.id}) {
            title
            description
            user {
              userName
            }
          }
        }
      GQL
    end

    it 'returns a specific blog with its user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['blog']

      expect(data['title']).to eq(blog.title)
      expect(data['user']['userName']).to eq("Jane Doe")
    end
  end

  describe 'user not found' do
    let(:query) do
      <<~GQL
        query {
          user(id: 9999) {
            userName
          }
        }
      GQL
    end

    it 'returns null for missing user' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['user']

      expect(data).to be_nil
    end
  end
end
