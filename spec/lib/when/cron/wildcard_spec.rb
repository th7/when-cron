require 'spec_helper'

describe Wildcard do
  describe '#==' do
    it 'returns true' do
      expect(Wildcard.new == 'asdf').to eq true
    end
  end

  describe '#<=' do
    it 'returns true' do
      expect(Wildcard.new <= 'asdf').to eq true
    end
  end

  describe '#>=' do
    it 'returns true' do
      expect(Wildcard.new >= 'asdf').to eq true
    end
  end

  describe '#<' do
    it 'returns true' do
      expect(Wildcard.new < 'asdf').to eq true
    end
  end

  describe '#>' do
    it 'returns true' do
      expect(Wildcard.new > 'asdf').to eq true
    end
  end

  describe '#first' do
    it 'returns zero' do
      expect(Wildcard.new.first).to eq 0
    end
  end

  describe '#last' do
    it 'returns zero' do
      expect(Wildcard.new.last).to eq 0
    end
  end
end
