require 'spec_helper'
include When

describe CronArray do
  let(:cron_array) { CronArray.new([1,2,3]) }

  describe '#==' do
    context 'the array contains the given value' do
      it 'returns true' do
        expect(cron_array == 1).to eq true
      end
    end

    context 'the array does not contain the given value' do
      it 'returns false' do
        expect(cron_array == 4).to eq false
      end
    end
  end
end
