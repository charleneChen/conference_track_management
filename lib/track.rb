class Track

  attr_accessor :morning_session, :afternoon_session

  @morning_start_time = '09:00AM'
  @afternoon_start_time = '01:00PM'
  @morning_session_time = 180
  @morning_session_max_time = 210
  @afternoon_session_min_time = 180
  @afternoon_session_max_time = 240
  @minTrackTime = 360
  @maxTrackTime = 420

  def initialize
    @morning_session = []
    @afternoon_session = []
  end

  def self.minTrackTime
    @minTrackTime
  end

  def self.maxTrackTime
    @maxTrackTime
  end

  def self.morning_start_time
    @morning_start_time
  end

  def itself.afternoon_start_time
    @afternoon_start_time
  end

  def self.morning_session_time
    @morning_session_time
  end

  def self.afternoon_session_min_time
    @afternoon_session_min_time
  end

  def self.afternoon_session_max_time
    @afternoon_session_max_time
  end

  # Sort an array of talks based on its minutes from short to long
  # Return an array of sorted talks
  def self.sortTalks!(talks)
    talks.sort_by! { |talk| talk.getMinutes }
  end

  # Return an array of possible talks, each possible has a same given sum
  def self.possibleTalksOfGivenSum(talks, sum)
    talks_size = talks.size
    possibles = []
    i = 0
    while (i < talks_size)
      current_sum = 0
      selected_talks = []
      j = i
      while (j < talks_size)
        current_sum += talks[j].getMinutes
        selected_talks << talks[j]
        if (current_sum == sum)
          possibles << selected_talks
          current_sum = 0
          selected_talks = []
        end
        j += 1
      end
      i += 1
    end
    return possibles
  end

  # The start time of each talk
  # Return a string like '09:00AM'
  def allocatedTime(now, minutes)
    flag = now.slice(-2, 2)
    now_hour_str = now[0, 2]
    now_minute = now[-4, 2].to_i
    total_minutes = now_minute + minutes

    if (total_minutes < 60)
      return now_hour_str + ':' + total_minutes.to_s + flag
    else
      now_hour = now_hour_str.to_i + 1
      if (now_hour < 10)
        now_hour_str = '0' + now_hour.to_s
      else
        now_hour_str = now_hour.to_s
      end
      if (total_minutes == 60)
        return now_hour_str + ':00' + flag
      else
        tmp = (total_minutes-60)
        if tmp < 10
          return now_hour_str + ':0' + tmp.to_s + flag
        else
          return now_hour_str + ':' + tmp.to_s + flag
        end
      end
    end
  end

  def deleteSessionTalks(session_talks, talks)
    for i in session_talks
      talks.delete_if { |talk| talk.eqlTo?(i) }
    end
  end

  def addTalkToSessions(talks1, talks2)
    talks1.each do |talk|
      self.morning_session << talk
    end
    talks2.each do |talk|
      self.afternoon_session << talk
    end
  end

  def printSession(session, start_time)
    allocated_time = start_time
    session.each do |talk|
      puts(allocated_time + ' ' + talk.name + ' ' + talk.minutes)
      allocated_time = allocatedTime(allocated_time, talk.getMinutes)
    end
    if (start_time == Track.morning_start_time)
      puts allocated_time + ' Lunch'
    else
      puts allocated_time + ' Networking Event'
    end
  end

  def printTrack
    self.printSession(self.morning_session, Track.morning_start_time)
    self.printSession(self.afternoon_session, Track.afternoon_start_time)
  end

end