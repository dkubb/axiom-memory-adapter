# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#insert' do
  subject { object.insert(gateway, other) }

  include_context 'relation'

  let!(:object) { described_class.new(schema)                          }
  let(:gateway) { described_class::Gateway.new(object, name, relation) }
  let(:other)   { Relation.new(header, [[3], [4]])                     }

  before do
    object[name] = gateway
  end

  it_should_behave_like 'a command method'

  it 'adds new tuples to the datastore' do
    subject
    expect { |block| object.read(gateway, &block) }
      .to yield_successive_args([1], [2], [3], [4])
  end

  it 'changes the gateway in the schema' do
    expect { subject }.to change(object, :schema)
  end
end
