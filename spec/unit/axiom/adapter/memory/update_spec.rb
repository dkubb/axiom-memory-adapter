# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#update' do
  subject { object.update(gateway, &function) }

  include_context 'relation'

  let!(:object)  { described_class.new(schema)                          }
  let(:gateway)  { described_class::Gateway.new(object, name, relation) }
  let(:function) { ->(tuple) { [2] }                                    }

  before do
    object[name] = gateway
  end

  it_should_behave_like 'a command method'

  it 'modifies the tuples in the datastore' do
    subject
    expect { |block| object.read(gateway, &block) }
      .to yield_successive_args([2])
  end

  it 'changes the gateway in the schema' do
    expect { subject }.to change(object, :schema)
  end
end
