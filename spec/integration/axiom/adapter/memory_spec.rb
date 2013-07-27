# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory do
  subject { described_class.new(schema) }

  include_context 'relation'

  before do
    subject[name] = relation
  end

  describe '#insert' do
    it 'inserts a new tuple' do
      subject[name].insert([[3], [4]])
      expect(subject[name].to_a).to eq([[1], [2], [3], [4]])
    end
  end

  describe '#replace' do
    it 'replaces with new tuples' do
      subject[name].replace([[2]])
      expect(subject[name].to_a).to eq([[2]])
    end
  end

  describe '#delete' do
    it 'deletes matching tuples' do
      subject[name].delete([[3], [4]])
      expect(subject[name].to_a).to eq([[1], [2]])
    end
  end

  describe '#update' do
    pending 'Design interface' do
      context 'with a Hash argument' do
        it 'updates matching tuples' do
          subject[name].update(id: 2)
          expect(subject[name].to_a).to eq([[2]])
        end
      end
    end

    context 'with a block' do
      it 'updates matching tuples' do
        subject[name].update { |tuple| [2] }
        expect(subject[name].to_a).to eq([[2]])
      end
    end
  end
end
