require 'spec_helper'

describe CronInterval do
  describe '#==' do
    context 'wildcard over int' do
      let(:cron_interval) { CronInterval.new(Wildcard.new, 3) }

      it 'returns true for zero and multiples of 3' do
        expect(cron_interval == (0 + rand(10)*3)).to eq true
      end

      it 'returns false for non zero non multiples of 3' do
        expect(cron_interval == (1 + rand(10)*3)).to eq false
        expect(cron_interval == (2 + rand(10)*3)).to eq false
      end
    end

    context 'cron range over int' do
      let(:cron_interval) { CronInterval.new(CronRange.new(8,39), 15) }

      it 'returns true for 8, 23, and 38' do
        expect(cron_interval == 8).to eq true
        expect(cron_interval == 23).to eq true
        expect(cron_interval == 38).to eq true
      end

      it 'returns false for 7, 24, 39, and 53' do
        expect(cron_interval == 7).to eq false
        expect(cron_interval == 24).to eq false
        expect(cron_interval == 39).to eq false
        expect(cron_interval == 53).to eq false
      end
    end
  end
end
