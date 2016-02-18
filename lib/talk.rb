class Talk

  # getters
  attr_reader :name, :minutes

  # input: String - name, minutes
  def initialize(name, minutes)
    @name = name
    @minutes = minutes
  end

  # Returns an integer
  def getMinutes
    @minutes.to_i
  end

  # input: an array of Talk instances
  # output: an integer
  def self.computeTotalTime(talks)
    total_time = 0
    talks.each do |talk|
      time = talk.getMinutes
      total_time += time
    end
    return total_time
  end

  # input: an instance of Talk
  # output: true or false
  def eqlTo?(talk)
    if (self.name == talk.name && self.minutes == talk.minutes)
      return true
    else
      return false
    end
  end

end