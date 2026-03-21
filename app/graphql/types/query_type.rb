# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Queries

    # User queries
    field :me, Types::UserType, null:true,
      description: "Returns the currently logged in user."


    # Ticket queries
    field :tickets, [Types::TicketType], null: true,
      description: "Returns all tickets. Returned values depend on User role; admin gets all, users get their own."

    field :ticket, Types::TicketType, null: true,
      description: "Fetches a single ticket by ID" do
        argument :id, ID, required: true
      end

    # Dashboard queiries
    field :dashboard_stats, Types::DashboardStatsType, null: false,
      description: "Returns stats for admin dashboard"

    #Functions
    def me
      context[:current_user]
    end

    def tickets
      current_user = context[:current_user]

      return Ticket.none unless current_user

      if current_user.admin?
        Ticket.all.order(created_at: :desc)
      else
        Ticket.where(requester: current_user).order(created_at: :desc)
      end
    end

    def ticket(id:)
      current_user = context[:current_user]
      return nil unless current_user

      if current_user.admin?
        Ticket.find(id: id)
      else
        Ticket.find_by(id: id, requester: current_user)
      end
    end

    def dashboard_stats
      {
        total_tickets: Ticket.count,
        open_tickets: Ticket.open.count,
        resolved_tickets: Ticket.resolved.count,
        high_priority_tickets: Ticket.where(priority: [:high, :critical]).count
      }
    end
  end
end
