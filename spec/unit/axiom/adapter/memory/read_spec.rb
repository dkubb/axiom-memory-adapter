# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#read' do
  let(:object)   { described_class.new(schema)               }
  let(:schema)   { { 'users' => relation }.freeze            }
  let(:relation) { Relation::Base.new('users', header, body) }
  let(:header)   { [[:id, Integer]]                          }
  let(:body)     { [[1], [2], [3]]                           }

  context 'with a block' do
    subject { object.read(relation) {} }

    it_should_behave_like 'a command method'

    it 'yields the expected tuples' do
      expect { |block| object.read(relation, &block) }
        .to yield_successive_args(*body)
    end

    it 'yields the expected types' do
      expect { |block| object.read(relation, &block) }
        .to yield_successive_args(Tuple, Tuple, Tuple)
    end
  end

  context 'without a block' do
    subject { object.read(relation) }

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
