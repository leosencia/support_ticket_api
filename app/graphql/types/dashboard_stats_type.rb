module Types
  class DashboardStatsType < Types::BaseObject
    field :total_tickets, Integer, null: false
    field :open_tickets, Integer, null: false
    field :resolved_tickets, Integer, null: false
    field :high_priority_tickets, Integer, null: false
  end
end
