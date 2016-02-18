require 'conference'

describe Conference do

  let(:lines_of_file) { 28 }

  before(:all) do
    file_path = '../input'
    @conference = Conference.new
    @conference.read_file(file_path)
  end

  it 'gets an input file path and returns an array' do
    expect(@conference.talks).to be_an_instance_of Array
  end

  it 'items in the returned array all are an instance of Talk' do
    @conference.talks.each do |talk|
      expect(talk).to be_an_instance_of Talk
    end
  end

  it 'length of the return array is same as the number of lines in the input file' do
    expect(@conference.talks.length).to eql(lines_of_file)
  end

  it 'should be able to create instances of Track with the computed number of tracks' do
    @conference.create_track(@conference.talks)
    expect(@conference.tracks_hash.length).to eql(@conference.number_of_tracks(@conference.talks))
  end

  it 'time of each track should be large than or equal to 360 minutes and less than or equal to 420 minutes' do
    @conference.compute_and_print_all_tracks
    @conference.tracks_hash.each_value do |track|
      time_of_track = Talk.computeTotalTime(track.morning_session) + Talk.computeTotalTime(track.afternoon_session)
      expect(time_of_track).to be_between(360, 420).inclusive
    end
  end

  it 'morning session time of each track must be 180 minutes' do
    @conference.tracks_hash.each_value do |track|
      morning_time_of_track = Talk.computeTotalTime(track.morning_session)
      expect(morning_time_of_track).to eql(180)
    end
  end

  it 'afternoon time of each track should be large than or equal to 180 minutes and less than or equal to 240 minutes' do
    @conference.tracks_hash.each_value do |track|
      afternoon_time_of_track = Talk.computeTotalTime(track.afternoon_session)
      expect(afternoon_time_of_track).to be_between(180, 240).inclusive
    end
  end

end