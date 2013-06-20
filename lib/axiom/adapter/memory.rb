# encoding: utf-8

require 'axiom'

module Axiom
  module Adapter

    # A reference adapter for in-memory information
    class Memory
      include Adamantium

      # Initialize a Memory adapter
      #
      # @return [undefined]
      #
      # @api private
      def initialize
        # TODO: add a registry to map base relation names to tuples
      end

      # Insert a set of tuples into memory
      #
      # @example insert a new user
      #   header = Axiom::Header.coerce([ [ :name, String ] ])
      #   tuple  = Axiom::Tuple.new(header, [ 'Dan Kubb' ])
      #   adapter.insert(users, [ tuple ])
      #
      # @param [Axiom::Relation] relation
      # @param [Enumerable<Axiom::Tuple>] tuples
      #   a set of tuples to insert into the relation
      #
      # @return [self]
      #
      # @api public
      def insert(relation, tuples)
        raise NotImplementedError, "#{self.class}##{__method__} not implemented"
      end

      # Read the results from memory
      #
      # @example
      #   adapter.read(users) { |row| ... }
      #
      # @param [Axiom::Relation] relation
      #
      # @yield [row]
      #
      # @yieldparam [Array] row
      #   each row in the results
      #
      # @return [self]
      #
      # @api public
      def read(relation)
        raise NotImplementedError, "#{self.class}##{__method__} not implemented"
      end

      # Update the tuples in memory that intersect the relation
      #
      # @example update all users to be active
      #   header = Axiom::Header.coerce([ [ :active, TrueClass ] ])
      #   tuple  = Axiom::Tuple.new(header, [ true ])
      #   adapter.update(inactive_users, tuple)
      #
      # The tuple header must be a subset of the base relation header. Every
      # tuple in the relation should have the overlapping attributes changed
      # to match the tuple. The tuple header must not be a superset of any
      # keys and cause a uniqueness constraint violation.
      #
      # @param [Axiom::Relation] relation
      # @param [Axiom::Tuple] tuple
      #
      # @return [self]
      #
      # @api public
      def update(relation, tuple)
        raise NotImplementedError, "#{self.class}##{__method}} not implemented"
      end

      # Delete tuples from memory that intersect with the relation
      #
      # @example
      #   adapter.delete(inactive_users)
      #
      # @param [Axiom::Relation] relation
      #
      # @return [self]
      #
      # @api public
      def delete(relation)
        raise NotImplementedError, "#{self.class}##{__method}} not implemented"
      end

    end # class Memory
  end # module Adapter
end # module Axiom

require 'axiom/adapter/memory/version'
