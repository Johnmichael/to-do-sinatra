class Task

  @@list = []

  attr_accessor :name, :detail, :notes
  attr_reader :id

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
