module Mutations
  class UpdateTicket < BaseMutation
    argument :id, ID, required: true
    argument :subject, String, required: false
    argument :description, String, required: false
    argument :category, String, required: false
    argument :priority, String, required: false
    argument :status, String, required: false
    argument :assigned_to, String, required: false

    field :ticket, Types::TicketType, null: true
    field :errors, [String], null: false

    def resolve(id:, **args)
      current_user = context[:current_user]
      return {ticket: nil, errors: ["Not authenticated"]} unless current_user

      ticket = Ticket.find_by(id: id)
      return {ticket: nil, errors: ["Ticket not found"]} unless ticket

      if current_user.admin?
        ticket.update(args)
        {ticket: ticket, errors: ticket.errors.full_messages}
      elsif ticket.requester == current_user.id && ticket.open? #users can only edit if ticket is still open
        # Users cannot change status so we exlude it from editing using slice()
        allowed = args.slice(:subject, :description, :category, :priority)
        ticket.update(allowed)
        {ticket: ticket, errors: ticket.errors.full_messages}
      else
        {ticket: ticket, errors: ["Not authorized to update this ticket"]}
      end
    end

  end

end
