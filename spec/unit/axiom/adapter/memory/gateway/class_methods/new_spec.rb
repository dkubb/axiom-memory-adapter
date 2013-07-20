# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory::Gateway, '.new' do
  subject { object.new(adapter, name, relation) }

  include_context 'relation'

  let(:object)  { described_class   }
  let(:adapter) { double('adapter') }

  it { should be_instance_of(described_class) }

  its(:name)     { should be(name)     }
  its(:relation) { should be(relation) }

  it 'stringifies the name' do
    name = double('name')
    expect(name).to receive(:to_str)
    object.new(adapter, name, relation)
  end

  it 'materializes the relation' do
    relation = double('relation')
    expect(relation).to receive(:materialize)
    object.new(adapter, name, relation)
  end
end
