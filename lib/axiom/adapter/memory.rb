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
      #   function = lambda { |tuple| ... }
      #   adapter.update(inactive_users, function)
      #
      # The function will be applied to every tuple in the relation and will
      # return a new tuple to replace the original. The example above shows it
      # being a Proc object, but a first-class Axiom object should be created
      # that represents something that accepts a tuple and returns a tuple,
      # rather than simply extracting a value from a tuple attribute.
      #
      # @param [Axiom::Relation] relation
      # @param [#call] function
      #
      # @return [self]
      #
      # @api public
      def update(relation, function)
        raise NotImplementedError, "#{self.class}##{__method__} not implemented"
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
        raise NotImplementedError, "#{self.class}##{__method__} not implemented"
      end

    end # class Memory
  end # module Adapter
end # module Axiom

require 'axiom/adapter/memory/version'
