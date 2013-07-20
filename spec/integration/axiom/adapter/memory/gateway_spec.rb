# encoding: utf-8

require 'spec_helper'

describe Axiom::Adapter::Memory::Gateway do
  subject { described_class.new(adapter, name, relation) }

  include_context 'relation'

  let(:adapter) { Axiom::Adapter::Memory.new(schema) }

  describe '#insert' do
    it 'inserts a new tuple' do
      new_gateway = subject.insert([[3], [4]])
      expect(new_gateway.to_a).to eq([[1], [2], [3], [4]])
    end
  end

  describe '#replace' do
    it 'replaces with new tuples' do
      new_gateway = subject.replace([[2]])
      expect(new_gateway.to_a).to eq([[2]])
    end
  end

  describe '#delete' do
    it 'deletes matching tuples' do
      new_gateway = subject.delete([[3], [4]])
      expect(new_gateway.to_a).to eq([[1], [2]])
    end
  end

  describe '#update' do
    pending 'Design interface' do
      context 'with a Hash argument' do
        it 'updates matching tuples' do
          new_gateway = subject.update(id: 2)
          expect(new_gateway.to_a).to eq([[2]])
        end
      end
    end

    context 'with a block' do
      it 'updates matching tuples' do
        new_gateway = subject.update { |tuple| [2] }
        expect(new_gateway.to_a).to eq([[2]])
      end
    end
  end
end
