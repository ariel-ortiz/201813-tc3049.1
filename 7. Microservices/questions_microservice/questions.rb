require 'yaml'
require 'json'
require 'sinatra'

PORT = 8081
URL = "http://localhost:#{ PORT }"

set :bind, "0.0.0.0"
set :port, PORT

QUESTIONS = YAML.load_file('questions.yml')

before do
  content_type :json
end

not_found do
  {'error' => "Resource not found: #{ request.path_info }"}.to_json
end

get '/questions' do
  JSON.pretty_generate(QUESTIONS.map.with_index do |q, i|
    {
      'id' => i,
      'answer' => q['options'][q['answer']],
      'url' => "#{ URL }/questions/#{ i }"
    }
  end)
end
