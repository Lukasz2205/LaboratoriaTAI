require 'swagger_helper'

RSpec.describe 'authentication', type: :request do

  path '/login' do 
    post('Login user') do 
      response(200, 'successful') do 
        consumes 'application/json'
        parameter login: :user, in: :body, schema: {
          type: :object,
          properties: {
            login: { type: :string },
            password: { type: :string }
          },
          required: %w[token login password]
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end 
end
