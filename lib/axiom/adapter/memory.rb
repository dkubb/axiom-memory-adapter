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
      # @return [Hash{String => Axiom::Relation::Variable}]
      #
      # @api private
      attr_reader :schema
      private :schema

      # Initialize a Memory adapter
      #
      # @param [Hash{String => Axiom::Relation::Variable}] schema
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
      # @return [Axiom::Relation::Variable]
      #
      # @api private
      def [](name)
        schema.fetch(name) do
          raise UnknownRelationError, "the relation named #{name} is unknown"
        end
      end

      # Set the gateway in the schema
      #
      # @param [#to_str] name
      # @param [Axiom::Relation::Materialized] relation
      #
      # @return [undefined]
      #
      # @api private
      def []=(name, relation)
        schema[name] = Relation::Variable.new(relation)
      end

    end # Memory
  end # Adapter
end # Axiom

require 'axiom/adapter/memory/version'
