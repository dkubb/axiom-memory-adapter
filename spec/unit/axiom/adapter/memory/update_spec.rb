# encoding: utf-8

require 'spec_helper'
require 'axiom/adapter/memory'

describe Adapter::Memory, '#update' do
  subject { object.update(relation, function) }

  let(:object)   { described_class.new(schema)               }
  let(:schema)   { { 'users' => relation }.freeze            }
  let(:relation) { Relation::Base.new('users', header, body) }
  let(:header)   { [[:id, Integer]]                          }
  let(:body)     { [[1]]                                     }
  let(:function) { ->(tuple) { [2] }                         }

  it_should_behave_like 'a command method'

  it 'modifies the tuples in the datastore' do
    subject
    expect { |block| object.read(relation, &block) }
      .to yield_successive_args([2])
  end
end
