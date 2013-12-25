require 'spec_helper'
include When

describe Cron do
  let(:now) { Time.new(2013, 6, 15, 12, 30, 30) }

  describe '#==' do
    context 'simple cron' do
      let(:cron) { Cron.new('30 12 15 6 6') }
      it 'returns true for now' do
        expect(cron == now).to eq true
      end

      it 'returns false for an hour earlier' do
        expect(cron == now - 3600).to eq false
      end
    end

    context 'complex cron' do
      let(:cron) { Cron.new('25-35/5 */12 */5 4-8/2 6') }
      it 'returns true for now' do
        expect(cron == now).to eq true
      end

      it 'returns false for an hour earlier' do
        expect(cron == now - 3600).to eq false
      end
    end
  end
end
