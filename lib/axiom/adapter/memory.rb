# encoding: utf-8

require 'axiom'
require 'thread_safe'

module Axiom
  module Adapter

    # A reference adapter for in-memory information
    class Memory
      include Adamantium::Flat

      # The schema
      #
      # @return [Hash{String => Axiom::Adapter::Memory::Gateway}]
      #
      # @api private
      attr_reader :schema
      private :schema

      # Initialize a Memory adapter
      #
      # @param [Hash{String => Axiom::Adapter::Memory::Gateway}] schema
      #
      # @return [undefined]
      #
      # @api private
      def initialize(schema = {})
        @schema = ThreadSafe::Hash[schema]
      end

      # Get gateway in the schema
      #
      # @param [#to_str] name
      #
      # @return [Axiom::Adapter::Memory::Gateway]
      #
      # @api private
      def [](name)
        schema.fetch(name)
      end

      # Set the gateway in the schema
      #
      # @param [#to_str] name
      # @param [Axiom::Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      def []=(name, relation)
        schema[name] = Gateway.new(self, name, relation)
      end

      # Insert a set of tuples into memory
      #
      # @example insert a new user
      #   header = Axiom::Header.coerce([[:name, String]])
      #   tuple  = Axiom::Tuple.new(header, ['Dan Kubb'])
      #   adapter.insert(users, [tuple])
      #
      # @param [Axiom::Adapter::Memory::Gateway] gateway
      # @param [Enumerable<Tuple>] tuples
      #   a set of tuples to insert into the relation
      #
      # @return [self]
      #
      # @api public
      def insert(gateway, tuples)
        self[gateway.name] = gateway.relation.insert(tuples)
        self
      end

      # Read the results from memory
      #
      # @example
      #   adapter.read(users) { |tuple| ... }
      #
      # @param [Axiom::Adapter::Memory::Gateway] gateway
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the result set
      #
      # @return [self]
      #
      # @api public
      def read(gateway, &block)
        return to_enum(__method__, gateway) unless block_given?
        self[gateway.name].each(&block)
        self
      end

      # Update the tuples in memory that intersect the relation
      #
      # @example update all inactive users
      #   adapter.update(inactive_users) { |tuple| ... }
      #
      # The function will be applied to every tuple in the relation and will
      # return a new tuple to replace the original. The example above shows it
      # being a Proc object, but a first-class Axiom object should be created
      # that represents something that accepts a tuple and returns a tuple,
      # rather than simply extracting a value from a tuple attribute.
      #
      # @param [Axiom::Adapter::Memory::Gateway] gateway
      #
      # @yield [tuple]
      # @yieldparam [Axiom::Relation::Tuple] tuple
      # @yieldreturn [Axiom::Relation::Tuple]
      #
      # @return [self]
      #
      # @api public
      def update(gateway, &block)
        self[gateway.name] = gateway.relation.update(&block)
        self
      end

      # Delete tuples from memory that intersect with the relation
      #
      # @example
      #   adapter.delete(inactive_users)
      #
      # @param [Axiom::Adapter::Memory::Gateway] gateway
      # @param [Relation] other
      #
      # @return [self]
      #
      # @api public
      def delete(gateway, other)
        self[gateway.name] = gateway.relation.delete(other)
        self
      end

    end # Memory
  end # Adapter

  # XXX: patch axiom relations
  class Relation

    # XXX: patch #update into Materialized
    class Materialized

      # Return an updated materialized relation
      #
      # @example
      #   updated = materialized.update { |tuple| ... }
      #
      # @return [Axiom::Relation::Materialized]
      #
      # @api public
      def update(&block)
        replace(map(&block))
      end

    end # Materialized
  end # Relation
end # Axiom

require 'axiom/adapter/memory/gateway'

require 'axiom/adapter/memory/version'
