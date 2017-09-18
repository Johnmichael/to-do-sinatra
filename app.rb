require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('pry')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  @list = Task.all
  erb(:input)
end

post('/') do
  name = params["name"]
  detail = params["detail"]

  task_hash = {"name" => name, "detail" => detail}

  task = Task.new(task_hash)
  task.save
  @list = Task.all
  erb(:input)
end

get('/:id') do
  @task = Task.search(params[:id])
  erb(:task_detail)
end

post('/:id') do
  @task = Task.search(params[:id])
  Task.remove(@task.id)
  redirect '/'
  erb(:task_detail)
end


get('/update/:id') do
  @task = Task.search(params[:id])
  erb(:update)
end

post('/update/:id') do
  @task = Task.search(params[:id])

  name = params["name"]
  detail = params["detail"]
  notes = params["notes"]

  Task.update(@task.id, name, detail, notes)
  erb(:update)
end
