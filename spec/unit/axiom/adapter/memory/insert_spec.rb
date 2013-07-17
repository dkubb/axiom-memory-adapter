# encoding: utf-8

require 'spec_helper'
require 'axiom/adapter/memory'

describe Adapter::Memory, '#insert' do
  subject { object.insert(relation, tuples) }

  let(:object)   { described_class.new(schema)               }
  let(:schema)   { { 'users' => relation }.freeze            }
  let(:relation) { Relation::Base.new('users', header, body) }
  let(:header)   { [[:id, Integer]]                          }
  let(:body)     { [[1]]                                     }
  let(:tuples)   { [[2], [3]]                                }

  it_should_behave_like 'a command method'

  it 'adds the tuples to the datastore' do
    subject
    expect { |block| object.read(relation, &block) }
      .to yield_successive_args([1], [2], [3])
  end
end
