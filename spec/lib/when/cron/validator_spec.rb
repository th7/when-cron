require 'spec_helper'
include When

describe Cron::Validator do
  describe '.valid?' do
    context 'number of parts' do
      it 'returns true with 5 space separated parts' do
        expect(Cron::Validator.valid?('* * * * *')).to be true
      end

      [ 1, 3, 6, 9 ].each do |i|
        cron = (['*'] * i).join(' ')
        it "returns false for '#{cron}'" do
          expect(Cron::Validator.valid?(cron)).to be false
        end
      end
    end
    context 'minutes' do
      [ '0', '1', '59' ].each do |min|
        it "returns true when minute is #{min}" do
          expect(Cron::Validator.valid?("#{min} * * * *")).to be true
        end
      end

      [ '60', '134', '75' ].each do |min|
        it "returns false when minute is #{min}" do
          expect(Cron::Validator.valid?("#{min} * * * *")).to be false
        end
      end
    end

    context 'hours' do
      [ '0', '5', '23' ].each do |hour|
        it "returns true when hour is #{hour}" do
          expect(Cron::Validator.valid?("* #{hour} * * *")).to be true
        end
      end

      [ '24', '50', '999' ].each do |hour|
        it "returns false when hour is #{hour}" do
          expect(Cron::Validator.valid?("* #{hour} * * *")).to be false
        end
      end
    end

    context 'days' do
      [ '1', '5', '31' ].each do |day|
        it "returns true when day is #{day}" do
          expect(Cron::Validator.valid?("* * #{day} * *")).to be true
        end
      end

      [ '0', '32', '467' ].each do |day|
        it "returns false when day is #{day}" do
          expect(Cron::Validator.valid?("* * #{day} * *")).to be false
        end
      end
    end

    context 'months' do
      [ '1', '5', '12', 'JAN', 'jan', 'AUG', 'DEC' ].each do |month|
        it "returns true when month is #{month}" do
          expect(Cron::Validator.valid?("* * * #{month} *")).to be true
        end
      end

      [ '0', '32', '467', 'MEY', 'JIN' ].each do |month|
        it "returns false when month is #{month}" do
          expect(Cron::Validator.valid?("* * * #{month} *")).to be false
        end
      end
    end

    context 'wdays' do
      [ '0', '5', '6', 'Mon', 'TUE', 'thu', 'saT' ].each do |wday|
        it "returns true when wday is #{wday}" do
          expect(Cron::Validator.valid?("* * * * #{wday}")).to be true
        end
      end

      [ '7', '32', '467', 'MIN', 'TUW' ].each do |wday|
        it "returns false when wday is #{wday}" do
          expect(Cron::Validator.valid?("* * * * #{wday}")).to be false
        end
      end
    end

    context 'characters' do
      [ '!', '&', '[', '\\' ].each do |char|
        5.times do |i|
          cron = [ '*', '*', '*', '*' ].insert(i, char).join(' ')
          it "returns false for #{cron}" do
            expect(Cron::Validator.valid?(cron)).to eq false
          end
        end
      end

      [ '-', '*', '/', ',' ].each do |char|
        5.times do |i|
          cron = [ '*', '*', '*', '*' ].insert(i, char).join(' ')
          it "returns true for #{cron}" do
            expect(Cron::Validator.valid?(cron)).to eq true
          end
        end
      end
    end
  end
end
