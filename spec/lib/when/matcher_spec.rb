require 'spec_helper'

describe Matcher do
  let(:matcher) { Matcher.new('today') }
  describe '#matches?' do
    it 'returns true if the date matches' do
      expect(matcher.matches?(Date.today)).to eq true
    end

    it 'returns false if the date does not match' do
      expect(matcher.matches?(Date.today - 1)).to eq false
    end
  end
end
