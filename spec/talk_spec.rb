require 'talk'

describe Talk do

  let(:talk) { Talk.new('The name of a talk', '30min') }

  # it 'should be an instance of Talk'  do
  #   expect(talk).to be_an_instance_of Talk
  # end

  it 'should be able to access its instance variables' do
    expect(talk.name).to eql('The name of a talk')
    expect(talk.minutes).to eql('30min')
  end

  it 'should be able to return an integer of minutes' do
    expect(talk.getMinutes).to eql(30)
  end

  it 'one talk equals to another talk when their name and minutes are same' do
    another_talk = Talk.new('The name of a talk', '30min')
    expect(another_talk.eqlTo?(talk)).to eql(true)
  end

  it 'should be able to return a total minutes of given talks ' do
    another_talk = Talk.new('The name of aother talk', '60min')
    expect(Talk.computeTotalTime([talk,another_talk])).to eql(90)
  end

end