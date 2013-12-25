require 'spec_helper'
include When

describe CronPart do
  context 'basic number' do
    let(:cron_part) { CronPart.new('5') }

    it 'returns true when compared to 5' do
      expect(cron_part == 5).to eq true
    end

    it 'returns false when compared to 4 or 6' do
      expect(cron_part == 4).to eq false
      expect(cron_part == 6).to eq false
    end
  end

  context 'list of numbers' do
    let(:cron_part) { CronPart.new('3,5,8') }

    it 'returns true when compared to 3, 5, or 8' do
      expect(cron_part == 3).to eq true
      expect(cron_part == 5).to eq true
      expect(cron_part == 8).to eq true
    end

    it 'returns false when compared to 2,4,6,7 or 9' do
      expect(cron_part == 2).to eq false
      expect(cron_part == 4).to eq false
      expect(cron_part == 6).to eq false
      expect(cron_part == 7).to eq false
      expect(cron_part == 9).to eq false
    end
  end

  context 'range' do
    let(:cron_part) { CronPart.new('3-5') }

    it 'returns true for 3, 4, or 5' do
      expect(cron_part == 3).to eq true
      expect(cron_part == 4).to eq true
      expect(cron_part == 5).to eq true
    end

    it 'returns false for 2 or 6' do
      expect(cron_part == 2).to eq false
      expect(cron_part == 6).to eq false
    end
  end

  context 'wildcard' do
    let(:cron_part) { CronPart.new('*') }

    it 'returns true for any number' do
      expect(cron_part == rand(1000)).to eq true
    end
  end

  context 'list and range' do
    let(:cron_part) { CronPart.new('2,3,5-7') }

    it 'returns true for 2, 3, 5, 6, or 7' do
      expect(cron_part == 2).to eq true
      expect(cron_part == 3).to eq true
      expect(cron_part == 5).to eq true
      expect(cron_part == 6).to eq true
      expect(cron_part == 7).to eq true
    end

    it 'returns false for 1, 4, or 8' do
      expect(cron_part == 1).to eq false
      expect(cron_part == 4).to eq false
      expect(cron_part == 8).to eq false
    end
  end

  context 'wildcard interval' do
    let(:cron_part) { CronPart.new('*/14') }

    it 'returns true for zero or any multiple of 14' do
      expect(cron_part == 0).to eq true
      expect(cron_part == 14 * rand(1000)).to eq true
    end

    it 'returns false for any non-zero non-multiple of 14' do
      expect(cron_part == 14 * rand(1000) + 1).to eq false
    end
  end

  context 'wildcard ranges' do
    let(:cron_part) { CronPart.new('*-5,9-*') }

    it 'returns true for 0 to 5 and 9 or above' do
      expect(cron_part == 0).to eq true
      expect(cron_part == rand(5)).to eq true
      expect(cron_part == 5).to eq true
      expect(cron_part == 9).to eq true
      expect(cron_part == 9 + rand(1000)).to eq true
    end
  end

  context 'range interval' do
    let(:cron_part) { CronPart.new('23-45/7') }

    it 'returns true for 23, 30, 37, and 44' do
      expect(cron_part == 23).to eq true
      expect(cron_part == 30).to eq true
      expect(cron_part == 37).to eq true
      expect(cron_part == 44).to eq true
    end

    it 'returns false for 16, 24, 43, 51' do
      expect(cron_part == 16).to eq false
      expect(cron_part == 24).to eq false
      expect(cron_part == 43).to eq false
      expect(cron_part == 51).to eq false
    end
  end

  context 'list, range, wildcard' do
    let(:cron_part) { CronPart.new('1,2,5-7,9-*') }

    it 'returns true for 1, 2, 5, 6, 7, 9 and above' do
      expect(cron_part == 1).to eq true
      expect(cron_part == 2).to eq true
      expect(cron_part == 5).to eq true
      expect(cron_part == 6).to eq true
      expect(cron_part == 7).to eq true
      expect(cron_part == 9).to eq true
      expect(cron_part == 9 + rand(1000)).to eq true
    end

    it 'returns false for 0, 3, 4, 8' do
      expect(cron_part == 0).to eq false
      expect(cron_part == 3).to eq false
      expect(cron_part == 4).to eq false
      expect(cron_part == 8).to eq false
    end
  end
end
