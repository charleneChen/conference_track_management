require 'track'
require 'conference'

describe Track do

  let(:track) { Track.new }
  let(:min_track_time) { 360 }
  let(:max_track_time) { 420 }
  let(:morning_start_time) { '09:00AM' }
  let(:afternoon_start_time) { '01:00PM' }
  let(:morning_session_time) { 180 }
  let(:afternoon_session_min_time) { 180 }
  let(:afternoon_session_max_time) { 240 }

  before(:all) do
    # @conference = Conference.new
    # @conference.read_file('../input')
    @talks = []
    @talks << Talk.new('The name of a talk', '120min')
    @talks << Talk.new('The name of a talk 2', '60min')
    @talks << Talk.new('The name of a talk 2', '60min')
    @talks << Talk.new('The name of a talk 2', '30min')
  end

  it 'the minimum time of Track is 360 minutes' do
    expect(Track.minTrackTime).to eql(min_track_time)
  end

  it 'the maximum time of Track is 420 minutes' do
    expect(Track.maxTrackTime).to eql(max_track_time)
  end

  it 'morning session starts at 09:00AM' do
    expect(Track.morning_start_time).to eql(morning_start_time)
  end

  it 'afternoon session starts at 01:00PM' do
    expect(Track.afternoon_start_time).to eql(afternoon_start_time)
  end

  it 'morning session time must be 180 minutes' do
    expect(Track.morning_session_time).to eql(morning_session_time)
  end

  it 'afternoon session minimum time is 180 minutes' do
    expect(Track.afternoon_session_min_time).to eql(afternoon_session_min_time)
  end

  it 'afternoon session maximum time is 240 minutes' do
    expect(Track.afternoon_session_max_time).to eql(afternoon_session_max_time)
  end

  it 'has one morning session array and one afternoon session array' do
    expect(track.morning_session).to be_an_instance_of Array
    expect(track.afternoon_session).to be_an_instance_of Array
  end

  it 'selects all possible arrays of talks with given 180 minutes' do
    possibles = Track.possibleTalksOfGivenSum(@talks, 180)
    possibles.each do |possible|
      expect(Talk.computeTotalTime(possible)).to eql(180)
    end
  end

  it 'should be able to allocate exact start time for each talk based on its minutes' do
    next_start_time = track.allocatedTime(morning_start_time, 45)
    expect(next_start_time).to eql('09:45AM')
  end

  it 'should be able to assign some talks to two session of one track' do
    talks1 = Track.possibleTalksOfGivenSum(@talks,180).first
    talks2 = Track.possibleTalksOfGivenSum(@talks,240).first
    track.addTalkToSessions(talks1,talks2)
    expect(track.morning_session).to eql(talks1)
    expect(track.afternoon_session).to eql(talks2)
  end

  it 'should be able to delete talks from the entire talks' do
    talks1 = Track.possibleTalksOfGivenSum(@talks,180).first
    track.deleteSessionTalks(talks1, @talks)
    talks1.each do |talk|
      expect(@talks.include?(talk)).to eql(false)
    end
  end

  it "should be able to put more talks in the morning session when the morning session time is 210 minutes" do
    talks3 = Track.possibleTalksOfGivenSum(@talks, 210).first
    total_minutes = 0
    talks3.each do |talk|
      total_minutes += talk.getMinutes
    end
    expect(total_minutes).to eql(210)
  end

end