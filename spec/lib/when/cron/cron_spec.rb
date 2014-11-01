require 'spec_helper'
include When

describe Cron do
  let(:now) { Time.new(2013, 6, 15, 12, 30, 30) }
  let(:hour_earlier)  { now - 3600 }
  let(:day_earlier)   { now - 3600 * 24 }
  let(:week_earlier)  { now - 3600 * 24 * 7 }
  let(:month_earlier) { now - 3600 * 24 * 31 }

  describe '.valid?' do
    it 'returns false for strings it cannot interpret' do
      expect(Cron.valid?('* * * * a,b')).to be false
    end

    it 'returns true for cron string it can interpret' do
      expect(Cron.valid?('* * * * 1')).to be true
    end
  end

  describe '.valid' do
    context 'a valid cron string is given' do
      it 'returns a new cron object' do
        expect(Cron.valid('* * * * *')).to be_kind_of Cron
      end
    end

    context 'an invalid cron string is given' do
      it 'returns nil' do
        expect(Cron.valid('* * * * * *')).to be_nil
      end
    end
  end

  describe '#==' do
    context 'simple cron' do
      let(:cron) { Cron.new('30 12 15 6 6') }

      it 'returns true for now' do
        expect(cron == now).to eq true
      end

      it 'returns false for an hour earlier' do
        expect(cron == hour_earlier).to eq false
      end

      it 'returns true a week earlier' do
        expect(cron == week_earlier).to eq true
      end

    end

    context 'day of week and day of month' do
      context 'day of week is wildcard' do
        let(:cron) { Cron.new('30 12 15 * *') }

        it 'returns true for now' do
          expect(cron == now).to eq true
        end

        it 'returns false for an hour earlier' do
          expect(cron == hour_earlier).to eq false
        end

        it 'returns false a week earlier' do
          expect(cron == week_earlier).to eq false
        end

        it 'returns true a month earlier' do
          expect(cron == month_earlier).to eq true
        end
      end

      context 'day of month is wildcard' do
        let(:cron) { Cron.new('30 12 * * 6') }

        it 'returns true for now' do
          expect(cron == now).to eq true
        end

        it 'returns false for an hour earlier' do
          expect(cron == hour_earlier).to eq false
        end

        it 'returns true a week earlier' do
          expect(cron == week_earlier).to eq true
        end

        it 'returns false a month earlier' do
          expect(cron == month_earlier).to eq false
        end
      end

      context 'neither is wildcard' do
        let(:cron) { Cron.new('30 12 15 * 6') }

        it 'returns true for now' do
          expect(cron == now).to eq true
        end

        it 'returns false for an hour earlier' do
          expect(cron == hour_earlier).to eq false
        end

        it 'returns true a week earlier' do
          expect(cron == week_earlier).to eq true
        end

        it 'returns true a month earlier' do
          expect(cron == month_earlier).to eq true
        end
      end
    end

    context 'complex cron' do
      let(:cron) { Cron.new('25-35/5 */12 */5 4-8/2 6') }

      it 'returns true for now' do
        expect(cron == now).to eq true
      end

      it 'returns false for an hour earlier' do
        expect(cron == hour_earlier).to eq false
      end
    end

    context 'abbreviations' do
      let(:cron) { Cron.new('* * * JUN SAT')}

      it 'returns true for now' do
        expect(cron == now).to eq true
      end

      it 'returns false for a day earlier' do
        expect(cron == day_earlier).to eq false
      end
    end
  end
end
