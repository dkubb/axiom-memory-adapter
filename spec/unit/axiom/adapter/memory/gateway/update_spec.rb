# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory::Gateway, '#update' do
  subject { object.update(&block) }

  include_context 'relation'

  let!(:object)     { described_class.new(adapter, name, relation) }
  let(:adapter)     { double('adapter')                            }
  let(:new_gateway) { double('new_gateway')                        }
  let(:block)       { ->(tuple) { }                                }
  let(:tuple)       { double('tuple')                              }

  before do
    allow(adapter).to receive(:update).and_return(double).and_yield(tuple)
    allow(adapter).to receive(:[]).and_return(new_gateway)
  end

  it 'returns a new gateway' do
    expect(subject).to be(new_gateway)
  end

  it 'tells the adapter to update the relation' do
    expect(adapter).to receive(:update).with(relation)
    expect { |block| object.update(&block) }.to yield_with_args(tuple)
  end
end
