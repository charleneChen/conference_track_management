require_relative 'talk'
require_relative 'track'

class Conference

  attr_accessor :talks, :number_of_tracks, :total_talks_time, :tracks_hash

  def initialize
    @talks = []
    @number_of_tracks = 0
    @total_talks_time = 0
    @tracks_hash = {}
  end

  # Handle input file and creates an instance variable @talks - it is an array of Talk objects
  def read_file(file_path)
    file_path = File.expand_path(file_path, File.dirname(__FILE__))

    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        pattern = /\d+min/
        if pattern =~ line
          time = pattern.match(line).to_s
          index = pattern =~ line
          name = line[0, index-1]
          @talks << Talk.new(name, time)
        end
      end
    end
  end

  # Return an integer - the number of tracks
  def number_of_tracks(talks)
    @total_talks_time = Talk.computeTotalTime(talks)

    quotient = @total_talks_time / Track.maxTrackTime
    if @total_talks_time - (quotient * Track.maxTrackTime) >= Track.minTrackTime
      @number_of_tracks = quotient + 1
    else
      @number_of_tracks = quotient
    end
  end

  # Return a Hash value - Track objects
  def create_track(talks)
    self.number_of_tracks(talks)
    tracks_num = Array.new(@number_of_tracks) { |x| x+1 } # e.g. [1, 2]
    tracks_num.each do |track_num|
      @tracks_hash['Track ' + track_num.to_s] = Track.new
    end
  end

  def compute_and_print_all_tracks
    left_time = @total_talks_time - (@number_of_tracks * Track.morning_session_time)
    max_afternoon_session_occur_times = @total_talks_time / Track.maxTrackTime
    last_time = left_time - (Track.afternoon_session_max_time * max_afternoon_session_occur_times)

    @tracks_hash.each do |track_num, track|
      puts track_num + ':'

      talks_array1 = Track.possibleTalksOfGivenSum(@talks, Track.morning_session_time).first
      track.deleteSessionTalks(talks_array1, @talks)

      if left_time % Track.afternoon_session_min_time == 0
        talks_array2 = Track.possibleTalksOfGivenSum(@talks, Track.afternoon_session_min_time).first
      elsif left_time % Track.afternoon_session_max_time == 0
        talks_array2 = Track.possibleTalksOfGivenSum(@talks, Track.afternoon_session_max_time).first
      else
        if max_afternoon_session_occur_times <= @number_of_tracks && max_afternoon_session_occur_times != 0
          talks_array2 = Track.possibleTalksOfGivenSum(@talks, Track.afternoon_session_max_time).first
          max_afternoon_session_occur_times -= 1
        else
          if last_time >= Track.afternoon_session_min_time
            talks_array2 = Track.possibleTalksOfGivenSum(@talks, last_time).first
          end
        end
      end

      track.deleteSessionTalks(talks_array2, @talks)

      track.addTalkToSessions(talks_array1, talks_array2)

      track.printTrack
    end
  end

end