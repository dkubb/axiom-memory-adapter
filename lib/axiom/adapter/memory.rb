# encoding: utf-8

require 'axiom'
require 'thread_safe'

module Axiom
  module Adapter

    # A reference adapter for in-memory information
    class Memory
      include Adamantium::Flat

      # Raised when the relation name is unknown
      UnknownRelationError = Class.new(IndexError)

      # The schema
      #
      # @return [Hash{Symbol => Axiom::Relation}]
      #
      # @api private
      attr_reader :schema
      private :schema

      # Initialize a Memory adapter
      #
      # @example with a schema
      #   adapter = Axiom::Adapter::Memory.new(
      #     users: Axiom::Relation.new(
      #       [[:id, Integer], [:name, String]],
      #       [[1, 'Dan Kubb'], [2, 'John Doe']]
      #     )
      #   )
      #
      # @example without a schema
      #   adapter = Axiom::Adapter::Memory.new
      #
      # @param [Hash{Symbol => Axiom::Relation}] schema
      #
      # @return [undefined]
      #
      # @api public
      def initialize(schema = {})
        @schema = ThreadSafe::Hash.new
        schema.each { |name, relation| self[name] = relation }
      end

      # Get relation variable in the schema
      #
      # @example
      #   adapter[:users]  # => users relation
      #
      # @param [Symbol] name
      #
      # @return [Axiom::Relation]
      #
      # @api public
      def [](name)
        schema.fetch(name) do
          fail UnknownRelationError, "the relation named #{name} is unknown"
        end
      end

      # Set the relation variable in the schema
      #
      # @example
      #   adapter[:users] = users_relation
      #
      # @param [Symbol] name
      # @param [Axiom::Relation] relation
      #
      # @return [undefined]
      #
      # @api public
      def []=(name, relation)
        schema[name] = Relation::Variable::Materialized.new(relation)
      end

    end # Memory
  end # Adapter

  # XXX: patch Axiom:Relation
  class Relation

    # XXX: patch #update into Variable
    class Variable

      # Update a relation variable
      #
      # @example
      #   relvar.update { |tuple| ... }
      #
      # @return [Axiom::Relation::Variable]
      #
      # @api public
      def update(&block)
        replace(map(&block))
      end

    end # Variable
  end # Relation
end # Axiom

require 'axiom/adapter/memory/version'
