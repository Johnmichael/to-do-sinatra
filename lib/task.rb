class Task

  @@list = []

  attr_accessor :name, :detail, :notes
  attr_reader :id

  attr_reader(:description, :list_id)

   def initialize(attributes)
     @description = attributes.fetch(:description)
     @list_id = attributes.fetch(:list_id)
   end

   def self.all
     returned_tasks = DB.exec("SELECT * FROM tasks;")
     tasks = []
     returned_tasks.each() do |task|
       description = task.fetch("description")
       list_id = task.fetch("list_id").to_i() # The information comes out of the database as a string.
       tasks.push(Task.new({:description => description, :list_id => list_id}))
     end
     tasks
   end

   def save
     DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
   end

   def ==(another_task)
     self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
   end

  def initialize(task_hash)
    @name = task_hash["name"]
    @detail = task_hash["detail"]
    @notes = task_hash["notes"]
    @id = @@list.length+1
  end

  def self.all()
    @@list
  end

  def save()
    @@list.push(self)
  end

  def self.search(id)
    search_id = id.to_i
    @@list.each do |task|
      if search_id == task.id
        return task
      end
    end
  end

  def self.remove(id)
    @@list.map do |task|
      if task.id == id
        task.name = ""
        task.detail = ""
        task.notes = ""
      end
    end
  end

  def self.update(id, name, detail, notes)
    @@list.map do |task|
      if task.id == id
        task.detail = detail
        task.notes = notes
      end
    end
  end

end
