require 'sinatra'
require 'json'
require 'yaml'

# بارگذاری درس‌ها از فایل YAML
lessons = YAML.load_file('lessons.yml')

get '/' do
  erb :index, locals: { lessons: lessons }
end

# API برای دریافت لیست درس‌ها
get '/api/lessons' do
  content_type :json
  lessons.map { |l| { id: l['id'], name: l['name'] } }.to_json
end

# API برای دریافت خطوط یک درس مشخص
get '/api/lessons/:id' do
  content_type :json
  lesson = lessons.find { |l| l['id'] == params[:id].to_i }
  if lesson
    lesson.to_json
  else
    status 404
    { error: 'درس پیدا نشد' }.to_json
  end
end
