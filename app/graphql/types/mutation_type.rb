# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Auth mutations
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    field :logout, mutation: Mutations::Logout

    # ticket mutations
    field :create_ticket, mutation: Mutations::CreateTicket
    field :update_ticket, mutation: Mutations::UpdateTicket
    field :delete_ticket, mutation: Mutations::DeleteTicket
  end
end
