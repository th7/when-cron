require 'spec_helper'

describe CronMonth do
  let(:today) { Date.new(2013, 6, 15) }

  describe '#==' do
    context 'day equals today' do
      let(:cron_month) { CronMonth.new("#{today.month}") }

      it 'returns true for a date with the same month' do
        expect(cron_month == today).to eq true
      end

      it 'returns false for tomorrow' do
        expect(cron_month == (today >> 1)).to eq false
      end
    end

    context 'cron month is a range' do
      let(:cron_month) { CronMonth.new("#{(today << 3).month}-#{(today >> 3).month}") }

      it 'returns true for months within the range' do
        expect(cron_month == (today << 3)).to eq true
        expect(cron_month == (today >> 3)).to eq true
        expect(cron_month == (today)).to eq true
      end

      it 'returns false for months outside the range' do
        expect(cron_month == (today << 4)).to eq false
        expect(cron_month == (today >> 4)).to eq false
      end
    end

    context 'cron month is a list' do
      let(:cron_month) { CronMonth.new("#{(today << 1).month},#{today.month}") }

      it 'returns true for months in the list' do
        expect(cron_month == (today << 1)).to eq true
        expect(cron_month == today).to eq true
      end

      it 'returns false for months outside the list' do
        expect(cron_month == (today << 2)).to eq false
        expect(cron_month == today >> 1).to eq false
      end
    end

    context 'cron month is wildcard' do
      let(:cron_month) { CronMonth.new('*') }

      it 'returns true for any value' do
        expect(cron_month == (today >> rand(1000))).to eq true
      end
    end

    context 'cron month is list and range combination' do
      let(:cron_month) { CronMonth.new("#{today.month},#{(today >> 2).month}-#{(today >> 4).month}") }

      it 'returns true for today, today >> 2, today >> 3, and today >> 4' do
        expect(cron_month == today).to eq true
        expect(cron_month == (today >> 2)).to eq true
        expect(cron_month == (today >> 3)).to eq true
        expect(cron_month == (today >> 4)).to eq true
      end

      it 'returns false for today << 1, today >> 1, and today >> 5' do
        expect(cron_month == (today << 1)).to eq false
        expect(cron_month == (today >> 1)).to eq false
        expect(cron_month == (today >> 5)).to eq false
      end
    end

    context 'cron month is list, range, and wildcard combination' do
      let(:cron_month) { CronMonth.new("*-#{(today << 3).month},#{(today).month},#{(today >> 2).month}-#{(today >> 4).month}") }

      it 'returns true for today << 5 to today << 3, today, and today >> 2 to today >> 4' do
        expect(cron_month == (today << 5)).to eq true
        expect(cron_month == (today << 4)).to eq true
        expect(cron_month == (today << 3)).to eq true
        expect(cron_month == today).to eq true
        expect(cron_month == (today >> 2)).to eq true
        expect(cron_month == (today >> 3)).to eq true
        expect(cron_month == (today >> 4)).to eq true
      end

      it 'returns false for today << 2, today << 1, today >> 1, and today >> 5' do
        expect(cron_month == (today << 2)).to eq false
        expect(cron_month == (today << 1)).to eq false
        expect(cron_month == (today >> 1)).to eq false
        expect(cron_month == (today >> 5)).to eq false
      end
    end

    context 'cron month is wildcard interval' do
      let(:cron_month) { CronMonth.new("*/3") }

      it 'returns true for 3, 6, 9, and 12th' do
        expect(cron_month == (today << 3)).to eq true
        expect(cron_month == (today)).to eq true
        expect(cron_month == (today >> 3)).to eq true
        expect(cron_month == (today >> 6)).to eq true
      end

      it 'returns false for 1, 2, 4, 5, 7, 8, 10, 11' do
        expect(cron_month == (today << 5)).to eq false
        expect(cron_month == (today << 4)).to eq false
        expect(cron_month == (today << 2)).to eq false
        expect(cron_month == (today << 1)).to eq false
        expect(cron_month == (today >> 1)).to eq false
        expect(cron_month == (today >> 2)).to eq false
        expect(cron_month == (today >> 4)).to eq false
        expect(cron_month == (today >> 5)).to eq false
      end
    end

    context 'cron month is range interval' do
      let(:cron_month) { CronMonth.new('5-9/4') }

      it 'returns true for 5th, 9th' do
        expect(cron_month == (today << 1)).to eq true
        expect(cron_month == (today >> 3)).to eq true
      end

      it 'returns false for 4th, 8th, 10th' do
        expect(cron_month == (today << 2)).to eq false
        expect(cron_month == (today >> 2)).to eq false
        expect(cron_month == (today >> 4)).to eq false
      end
    end

    context 'cron is complex' do
      let(:cron_month) { CronMonth.new('*/5,3-6/3,9-10,12') }

      it 'returns true for 3, 5, 6, 9, 10, 12' do
        expect(cron_month == (today << 3)).to eq true
        expect(cron_month == (today << 1)).to eq true
        expect(cron_month == (today)).to eq true
        expect(cron_month == (today >> 3)).to eq true
        expect(cron_month == (today >> 4)).to eq true
        expect(cron_month == (today >> 6)).to eq true
      end

      it 'returns false for 1, 2, 4, 7, 8, and 11' do
        expect(cron_month == (today << 5)).to eq false
        expect(cron_month == (today << 4)).to eq false
        expect(cron_month == (today << 2)).to eq false
        expect(cron_month == (today >> 1)).to eq false
        expect(cron_month == (today >> 2)).to eq false
        expect(cron_month == (today >> 5)).to eq false
      end
    end
  end
end
