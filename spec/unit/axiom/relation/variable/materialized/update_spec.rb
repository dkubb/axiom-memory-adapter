# encoding: utf-8

require 'spec_helper'

describe Relation::Variable::Materialized, '#update' do
  subject { object.update { [2] } }

  let(:object)   { described_class.new(relation) }
  let(:relation) { Relation.new(header, [[1]])   }
  let(:header)   { [[:id, Integer]]              }

  it { should be_instance_of(described_class) }

  it { should be_materialized }

  it { should == [[2]] }
end
