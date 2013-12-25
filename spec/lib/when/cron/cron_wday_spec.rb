require 'spec_helper'

describe CronWDay do
  let(:today) { Date.new(2013, 6, 12) } #wednesday, wday == 3

  describe '#==' do
    context 'cron wday equals today' do
      let(:cron_wday) { CronWDay.new("#{today.wday}") }

      it 'returns true for a date with the same day' do
        expect(cron_wday == today).to eq true
      end

      it 'returns false for tomorrow' do
        expect(cron_wday == (today + 1)).to eq false
      end
    end

    context 'cron wday is a range' do
      let(:cron_wday) { CronWDay.new("#{(today - 2).wday}-#{(today + 2).wday}") }

      it 'returns true for days within the range' do
        expect(cron_wday == (today - 2)).to eq true
        expect(cron_wday == (today + 2)).to eq true
        expect(cron_wday == (today)).to eq true
      end

      it 'returns false for days outside the range' do
        expect(cron_wday == (today - 3)).to eq false
        expect(cron_wday == (today + 3)).to eq false
      end
    end

    context 'cron wday is a list' do
      let(:cron_wday) { CronWDay.new("#{(today - 1).wday},#{today.wday}") }

      it 'returns true for days in the list' do
        expect(cron_wday == (today - 1)).to eq true
        expect(cron_wday == today).to eq true
      end

      it 'returns false for days outside the list' do
        expect(cron_wday == (today - 2)).to eq false
        expect(cron_wday == today + 1).to eq false
      end
    end

    context 'cron wday is wildcard' do
      let(:cron_wday) { CronWDay.new('*') }

      it 'returns true for any value' do
        expect(cron_wday == (today + rand(1000))).to eq true
      end
    end

    context 'cron wday is list and range combination' do
      let(:cron_wday) { CronWDay.new("#{today.wday - 3},#{today.wday - 1}-#{today.wday + 1}") }

      it 'returns true for today - 3, today - 1, today, and today + 1' do
        expect(cron_wday == (today - 3)).to eq true
        expect(cron_wday == (today - 1)).to eq true
        expect(cron_wday == today).to eq true
        expect(cron_wday == (today + 1)).to eq true
      end

      it 'returns false for today - 2, today + 2, and today + 3' do
        expect(cron_wday == (today - 2)).to eq false
        expect(cron_wday == (today + 2)).to eq false
        expect(cron_wday == (today + 3)).to eq false
      end
    end

    context 'cron wday is list, range, and wildcard combination' do
      let(:cron_wday) { CronWDay.new("*-#{today.wday - 2},#{(today).wday},#{(today + 2).wday}-#{(today + 3).wday}") }

      it 'returns true for today - 3 to today - 2, today, and today + 2 to today + 3' do
        expect(cron_wday == (today - 3)).to eq true
        expect(cron_wday == (today - 2)).to eq true
        expect(cron_wday == today).to eq true
        expect(cron_wday == (today + 2)).to eq true
        expect(cron_wday == (today + 3)).to eq true
      end

      it 'returns false for today - 1 and today + 1' do
        expect(cron_wday == (today - 1)).to eq false
        expect(cron_wday == (today + 1)).to eq false
      end
    end

    context 'cron wday is wildcard interval' do
      let(:cron_wday) { CronWDay.new("*/2") }

      it 'returns true for 0, 2, 4, and 6' do
        expect(cron_wday == (today - 3)).to eq true
        expect(cron_wday == (today - 1)).to eq true
        expect(cron_wday == (today + 1)).to eq true
        expect(cron_wday == (today + 3)).to eq true
      end

      it 'returns false for 1, 3, 5' do
        expect(cron_wday == (today - 2)).to eq false
        expect(cron_wday == today).to eq false
        expect(cron_wday == (today + 2)).to eq false
      end
    end

    context 'cron wday is range interval' do
      let(:cron_wday) { CronWDay.new('3-5/2') }

      it 'returns true for 3 and 5' do
        expect(cron_wday == today).to eq true
        expect(cron_wday == (today + 2)).to eq true
      end

      it 'returns false for 0, 1, 2, 4, and 6' do
        expect(cron_wday == (today - 3)).to eq false
        expect(cron_wday == (today - 2)).to eq false
        expect(cron_wday == (today - 1)).to eq false
        expect(cron_wday == (today + 1)).to eq false
        expect(cron_wday == (today + 3)).to eq false
      end
    end

    context 'cron is complex' do
      let(:cron_wday) { CronWDay.new('*/4,5-6/2,1-2,3') }

      it 'returns true for 0, 1, 2, 3, 4, 5' do
        expect(cron_wday == (today - 3)).to eq true
        expect(cron_wday == (today - 2)).to eq true
        expect(cron_wday == (today - 1)).to eq true
        expect(cron_wday == today).to eq true
        expect(cron_wday == (today + 1)).to eq true
        expect(cron_wday == (today + 2)).to eq true
      end

      it 'returns false for 6' do
        expect(cron_wday == (today + 3)).to eq false
      end
    end
  end
end
