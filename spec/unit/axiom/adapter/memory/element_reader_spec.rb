# encoding: utf-8

require 'spec_helper'

describe Adapter::Memory, '#[]' do
  subject { object[name] }

  let!(:object) { described_class.new('users' => gateway) }
  let(:gateway) { double('gateway')                       }

  context 'with a known name' do
    let(:name) { 'users' }

    it { should be(gateway) }
  end

  context 'with an unknown name' do
    let(:name) { 'unknown' }

    specify { expect { subject }.to raise_error(KeyError) }
  end
end
