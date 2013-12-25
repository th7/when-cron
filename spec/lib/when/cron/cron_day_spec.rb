require 'spec_helper'

describe CronDay do
  let(:today) { Date.new(2013, 6, 15) }

  describe '#==' do
    context 'day equals today' do
      let(:cron_day) { CronDay.new("#{today.day}") }

      it 'returns true for a date with the same day' do
        expect(cron_day == today).to eq true
      end

      it 'returns false for tomorrow' do
        expect(cron_day == (today + 1)).to eq false
      end
    end

    context 'cron day is a range' do
      let(:cron_day) { CronDay.new("#{(today - 3).day}-#{(today + 3).day}") }

      it 'returns true for days within the range' do
        expect(cron_day == (today - 3)).to eq true
        expect(cron_day == (today + 3)).to eq true
        expect(cron_day == (today)).to eq true
      end

      it 'returns false for days outside the range' do
        expect(cron_day == (today - 4)).to eq false
        expect(cron_day == (today + 4)).to eq false
      end
    end

    context 'cron day is a list' do
      let(:cron_day) { CronDay.new("#{(today - 1).day},#{today.day}") }

      it 'returns true for days in the list' do
        expect(cron_day == (today - 1)).to eq true
        expect(cron_day == today).to eq true
      end

      it 'returns false for days outside the list' do
        expect(cron_day == (today - 2)).to eq false
        expect(cron_day == today + 1).to eq false
      end
    end

    context 'cron day is wildcard' do
      let(:cron_day) { CronDay.new('*') }

      it 'returns true for any value' do
        expect(cron_day == (today + rand(1000))).to eq true
      end
    end

    context 'cron day is list and range combination' do
      let(:cron_day) { CronDay.new("#{today.day},#{(today + 2).day}-#{(today + 4).day}") }

      it 'returns true for today, today + 2, today + 3, and today + 4' do
        expect(cron_day == today).to eq true
        expect(cron_day == (today + 2)).to eq true
        expect(cron_day == (today + 3)).to eq true
        expect(cron_day == (today + 4)).to eq true
      end

      it 'returns false for today - 1, today + 1, and today + 5' do
        expect(cron_day == (today - 1)).to eq false
        expect(cron_day == (today + 1)).to eq false
        expect(cron_day == (today + 5)).to eq false
      end
    end

    context 'cron day is list, range, and wildcard combination' do
      let(:cron_day) { CronDay.new("*-#{today.day},#{(today + 5).day},#{(today + 10).day}-#{(today + 12).day}") }

      it 'returns true for today - 14 to today, today + 5, and today + 10 to today + 12' do
        expect(cron_day == (today - 14)).to eq true
        expect(cron_day == (today - rand(13))).to eq true
        expect(cron_day == today).to eq true
        expect(cron_day == (today + 5)).to eq true
        expect(cron_day == (today + 10)).to eq true
        expect(cron_day == (today + 11)).to eq true
        expect(cron_day == (today + 12)).to eq true
      end

      it 'returns false for today - 15, today + 1, today + 9, and today + 13' do
        expect(cron_day == (today - 15)).to eq false
        expect(cron_day == (today + 1)).to eq false
        expect(cron_day == (today + 9)).to eq false
        expect(cron_day == (today + 13)).to eq false
      end
    end

    context 'cron day is wildcard interval' do
      let(:cron_day) { CronDay.new("*/13") }

      it 'returns true for 13th, 26th' do
        expect(cron_day == (today - 2)).to eq true
        expect(cron_day == (today + 11)).to eq true
      end

      it 'returns false for 12th, 14th, 25th, 27th' do
        expect(cron_day == (today - 3)).to eq false
        expect(cron_day == (today - 1)).to eq false
        expect(cron_day == (today + 10)).to eq false
        expect(cron_day == (today + 12)).to eq false
      end
    end

    context 'cron day is range interval' do
      let(:cron_day) { CronDay.new('5-13/4') }

      it 'returns true for 5th, 9th, 13th' do
        expect(cron_day == (today - 10)).to eq true
        expect(cron_day == (today - 6)).to eq true
        expect(cron_day == (today - 2)).to eq true
      end

      it 'returns false for 4th, 10th, and 12th' do
        expect(cron_day == (today - 11)).to eq false
        expect(cron_day == (today - 5)).to eq false
        expect(cron_day == (today - 3)).to eq false
      end
    end

    context 'cron is complex' do
      let(:cron_day) { CronDay.new('*/5,11-15/2,21-23,28') }

      it 'returns true for multiples of 5, 11, 13, 15, 21, 22, 23, and 29' do
        expect(cron_day == (today + rand(3)*5)).to eq true
        expect(cron_day == (today - rand(3)*5)).to eq true
        expect(cron_day == (today - 4)).to eq true
        expect(cron_day == (today - 2)).to eq true
        expect(cron_day == today).to eq true
        expect(cron_day == (today + 6)).to eq true
        expect(cron_day == (today + 7)).to eq true
        expect(cron_day == (today + 8)).to eq true
        expect(cron_day == (today + 13)).to eq true
      end

      it 'returns false for 1, 12, 19, and 27' do
        expect(cron_day == (today - 14)).to eq false
        expect(cron_day == (today - 3)).to eq false
        expect(cron_day == (today + 4)).to eq false
        expect(cron_day == (today + 12)).to eq false
      end
    end
  end
end
