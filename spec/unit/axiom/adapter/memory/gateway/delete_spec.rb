# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory::Gateway, '#delete' do
  subject { object.delete(other) }

  include_context 'relation'

  let!(:object)     { described_class.new(adapter, name, relation) }
  let(:adapter)     { double('adapter')                            }
  let(:new_gateway) { double('new_gateway')                        }
  let(:other)       { double('other')                              }

  before do
    allow(adapter).to receive(:delete).and_return(double)
    allow(adapter).to receive(:[]).and_return(new_gateway)
  end

  it 'returns a new gateway' do
    expect(subject).to be(new_gateway)
  end

  it 'tells the adapter to delete the other relation' do
    expect(adapter).to receive(:delete).with(relation, other)
    subject
  end
end
