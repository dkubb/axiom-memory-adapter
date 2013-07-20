# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#read' do
  include_context 'relation'

  let!(:object) { described_class.new(schema)                          }
  let(:gateway) { described_class::Gateway.new(object, name, relation) }

  before do
    object[name] = gateway
  end

  context 'with a block' do
    subject { object.read(gateway) {} }

    it_should_behave_like 'a command method'

    it 'yields the expected tuples' do
      expect { |block| object.read(gateway, &block) }
        .to yield_successive_args(*body)
    end

    it 'yields the expected types' do
      expect { |block| object.read(gateway, &block) }
        .to yield_successive_args(Tuple, Tuple, Tuple)
    end
  end

  context 'without a block' do
    subject { object.read(gateway) }

    it { should be_instance_of(to_enum.class) }

    it 'yields the expected tuples' do
      expect { |block| subject.each(&block) }
        .to yield_successive_args(*body)
    end

    it 'yields the expected types' do
      expect { |block| subject.each(&block) }
        .to yield_successive_args(Tuple, Tuple, Tuple)
    end
  end
end
