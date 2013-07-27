# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '.new' do
  context 'with a schema' do
    subject { described_class.new(schema) }

    let(:schema) { {} }

    it { should be_instance_of(described_class) }

    it 'creates a new thread safe hash for the schema' do
      klass = double('ThreadSafe::Hash')
      expect(klass).to receive(:new).and_return({})
      stub_const('ThreadSafe::Hash', klass)
      subject
    end
  end

  context 'without a schema' do
    subject { described_class.new }

    it { should be_instance_of(described_class) }

    it 'creates a new thread safe hash for the schema' do
      klass = double('ThreadSafe::Hash')
      expect(klass).to receive(:new).and_return({})
      stub_const('ThreadSafe::Hash', klass)
      subject
    end
  end
end
