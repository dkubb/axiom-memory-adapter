# encoding: utf-8

module Axiom
  module Adapter
    class Memory

      # A gateway relation to the memory adapter
      class Gateway < Relation
        include Adamantium::Flat, Relation::Proxy
        include Equalizer.new(:adapter, :name, :relation)

        # The adapter the gateway will use to fetch results
        #
        # @return [Axiom:Adapter::Memory]
        #
        # @api private
        attr_reader :adapter
        protected :adapter

        # The gateway name
        #
        # @example
        #   gateway.name  # => "users"
        #
        # @return [String]
        #
        # @api public
        attr_reader :name

        # The gateway relation
        #
        # @example
        #   gateway.relation  # => a set of tuples
        #
        # @return [Axiom::Relation]
        #
        # @api public
        attr_reader :relation

        # Initialize a memory gateway
        #
        # @param [Axiom::Adapter::Memory] adapter
        # @param [#to_str] name
        # @param [Axiom::Relation] relation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(adapter, name, relation)
          @adapter  = adapter
          @name     = name.to_str
          @relation = relation.materialize
        end

        # Return a relation that represents an insertion into a relation
        #
        # @example
        #   insertion = relation.insert(other)
        #
        # @param [Enumerable] other
        #
        # @return [Axiom::Adapter::Memory::Gateway]
        #
        # @api public
        def insert(other)
          adapter.insert(self, other)
          new
        end

        # Return a relation that represents a deletion from a relation
        #
        # @example
        #   deletion = relation.delete(other)
        #
        # @param [Enumerable] other
        #
        # @return [Axiom::Adapter::Memory::Gateway]
        #
        # @api public
        def delete(other)
          adapter.delete(self, other)
          new
        end

        # Return a relation that represents an update of a relation
        #
        # @example with a hash
        #   update = relation.update(a: 1, b: 2)
        #
        # @example with a block
        #   update = relation.update do |r|
        #     r[:name] = r.concat(r[:first], r[:last])
        #   end
        #
        # @param [Enumerable] other
        #
        # @return [Axiom::Adapter::Memory::Gateway]
        #
        # @api public
        def update(&block)
          # TODO: implement logic to handle restriction-like input
          adapter.update(self, &block)
          new
        end

      private

        # Return a new gateway for the relation
        #
        # @return [Axiom::Adapter::Memory::Gateway]
        #
        # @api private
        def new
          adapter[name]
        end

      end # Gateway

    end # Memory
  end # Adapter
end # Axiom
