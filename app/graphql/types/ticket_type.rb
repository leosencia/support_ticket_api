# frozen_string_literal: true

module Types
  class TicketType < Types::BaseObject
    field :id, ID, null: false
    field :subject, String, null: false
    field :description, String, null: false
    field :category, String, null: false
    field :priority, String, null: false
    field :status, String, null: false
    field :requester, Types::UserType, null: false
    field :assigned_to, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
