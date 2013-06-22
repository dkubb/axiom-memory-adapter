# encoding: utf-8

require 'axiom'

module Axiom
  module Adapter

    # A reference adapter for in-memory information
    class Memory
      include Adamantium

      # Initialize a Memory adapter
      #
      # @param [Hash{String => Relation::Materialized}] schema
      #
      # @return [undefined]
      #
      # @api private
      def initialize(schema = {})
        @schema = schema
      end

      # Insert a set of tuples into memory
      #
      # @example insert a new user
      #   header = Axiom::Header.coerce([ [ :name, String ] ])
      #   tuple  = Axiom::Tuple.new(header, [ 'Dan Kubb' ])
      #   adapter.insert(users, [ tuple ])
      #
      # @param [Relation] relation
      # @param [Enumerable<Tuple>] tuples
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
      #   adapter.read(users) { |tuple| ... }
      #
      # @param [Relation] relation
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the result set
      #
      # @return [self]
      #
      # @api public
      def read(relation, &block)
        return to_enum(__method__, relation) unless block_given?
        @schema.fetch(relation.name).each(&block)
        self
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
      # @param [Relation] relation
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
      # @param [Relation] relation
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
