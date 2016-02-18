require_relative 'conference'

class Main
  # =========================================================================================================
  # unless ARGV.length == 1
  #   puts 'Usage: ruby conference.rb ../input'
  #   exit
  # end
  # file_path = ARGV[0]

  print 'Please input the file path of your test data (eg. ../input): '
  file_path = STDIN.gets.chomp

  conference = Conference.new
  conference.read_file(file_path)
  conference.create_track(conference.talks)

  # using sortTalks! method will result in different return possibles of Track.possibleTalksOfGivenSum
  # Track.sortTalks!(@talks)

  conference.compute_and_print_all_tracks
end