require_relative '../decorator'

describe Decorator do
  describe '#correct_name' do
    it 'gives correct_name to the decorated object' do
      nameable = instance_double('Nameable', correct_name: 'Sample Name')
      decorator = Decorator.new(nameable)
      expect(decorator.correct_name).to eq('Sample Name')
    end
  end
end
