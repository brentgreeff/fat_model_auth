# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FatModelAuth::GateKeeper do
  let(:gate_keeper) do
    described_class.new([:edit, { if: ->(_model, user) { user == :admin } }])
  end

  it 'correctly evaluates permissions for a single call' do
    expect(gate_keeper.check(nil, :admin).to_edit?).to be true
    expect(gate_keeper.check(nil, :guest).to_edit?).to be false
  end

  context 'when allows is called with no condition' do
    it 'raises ArgumentError immediately' do
      expect { described_class.new([:edit, {}]) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError when if: is nil' do
      expect { described_class.new([:edit, { if: nil }]) }.to raise_error(ArgumentError)
    end
  end

  it 'is not confused when check is called again before reading the result' do
    admin_check = gate_keeper.check(nil, :admin)

    # Simulate a second concurrent request overwriting shared state
    gate_keeper.check(nil, :guest)

    # admin_check should still reflect :admin — fails with current implementation
    expect(admin_check.to_edit?).to be true
  end
end
