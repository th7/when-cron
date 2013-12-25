require 'spec_helper'

describe Rule do
  let(:today) { Date.today }

  describe '#matches?' do
    context 'rule matches this day of the week' do
      let(:rule) { Rule.new("* * #{today.wday}") }

      it 'returns true when given today' do
        expect(rule.matches?(today)).to eq true
      end

      it 'returns true when the week changes' do
        expect(rule.matches?(today + (rand(100)*7))).to eq true
      end

      it 'returns false when given tomorrow' do
        expect(rule.matches?(today + 1)).to eq false
      end
    end

    context 'rule matches this month' do
      let(:rule) { Rule.new("* #{today.month} *") }

      it 'returns true when given a date from this month' do
        expect(rule.matches?(today)).to eq true
      end

      it 'returns true when the year changes' do
        expect(rule.matches?(today >> (rand(100)*12))).to eq true
      end

      it 'returns false when given a date not from this month' do
        expect(rule.matches?(today + 31)).to eq false
      end
    end

    context 'rule matches this day of the month' do
      let(:rule) { Rule.new("#{today.day} * *") }

      it 'returns true when given a date matching today' do
        expect(rule.matches?(today)).to eq true
      end

      it 'returns true when as the month changes' do
        expect(rule.matches?(today >> rand(100))).to eq true
      end

      it 'returns false when given a day other than today' do
        expect(rule.matches?(today + 1)).to eq false
      end
    end

    context 'rule matches day of week and day of month' do
      let(:rule) { Rule.new("#{today.day} * #{today.wday}") }

      it 'returns false if only the day matches' do
        expect(rule.matches?(today >> 1)).to eq false
      end

      it 'returns false if only the wday matches' do
        expect(rule.matches?(today + 7)).to eq false
      end

      it 'returns true if wday and day both match' do
        expect(rule.matches?(today)).to eq true
      end
    end
  end
end
