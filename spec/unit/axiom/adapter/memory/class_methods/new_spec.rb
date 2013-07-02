# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '.new' do
  context 'with a schema' do
    subject { described_class.new(schema) }

    let(:schema) { {} }

    it { should be_instance_of(described_class) }
  end

  context 'without a schema' do
    subject { described_class.new }

    it { should be_instance_of(described_class) }
  end
end
