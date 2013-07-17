# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#delete' do
  subject { object.delete(relation) }

  let(:object)   { described_class.new(schema)               }
  let(:schema)   { { 'users' => relation }.freeze            }
  let(:relation) { Relation::Base.new('users', header, body) }
  let(:header)   { [[:id, Integer]]                          }
  let(:body)     { [[1], [2], [3]]                           }

  it_should_behave_like 'a command method'

  it 'removes the tuples from the datastore' do
    subject
    expect { |block| object.read(relation, &block) }.to_not yield_control
  end
end
