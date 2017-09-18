require("spec_helper")


describe('creates a task object') do
  describe('#initialize') do
    task = Task.new({"name" => "Tasks", "detail" => "things to do"})

    it("saves initializtion values as intance variables") do
      expect(task.name).to eq("Tasks")
    end

    it("saves initializtion values as intance variables") do
      expect(task.detail).to eq("things to do")
    end
  end
end
