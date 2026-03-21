module Mutations
  class CreateTicket < BaseMutation
    argument :subject, String, required: true
    argument :description, String, required: true
    argument :category, String, required: true
    argument :priority, String, required: true

    field :ticket, Types::TicketType, null: true
    field :errors, [String], null: false

    def resolve(subject:, description:, category:, priority:)
      current_user = context[:current_user]
      return {ticket: nil, errors: ["Not logged in"]} unless current_user

      ticket = Ticket.new(
        subject: subject,
        description: description,
        category: category,
        priority: priority,
        requester: current_user,
        status: :open
      )

      if ticket.save
        { ticket: ticket, errors: []}
      else
        { ticket: nil, errors: ticket.errors.full_messages}
      end
    end

  end
end
