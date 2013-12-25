require 'spec_helper'
include When

describe CronRange do
  let(:cron_range) { CronRange.new(1, 3) }
  describe '#==' do
    it 'returns true if value is within range' do
      expect(cron_range == 1).to eq true
      expect(cron_range == 2).to eq true
      expect(cron_range == 3).to eq true
    end

    it 'returns false if value is outside range' do
      expect(cron_range == 4).to eq false
      expect(cron_range == 0).to eq false
    end
  end
end
