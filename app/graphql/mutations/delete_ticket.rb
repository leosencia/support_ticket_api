module Mutations
  class DeleteTicket < BaseMutation
    argument :id, ID, required: true

    field :message, String, null: true
    field :errors, [String], null: false

    def resolve(id:)
      current_user = context[:current_user]
      return {message: nil, errors: ["Not authenticated"]} unless current_user

      ticket = Ticket.find_by(id: id)
      return {message: nil, errors: ["Ticket does not exist"]} unless current_user

      if current_user.admin?
        ticket.destroy
        {message: "Ticket sucessfully removed", errors: []}
      elsif ticket.requester == current_user.id && ticket.open?
        ticket.destroy
        {message: "Ticket succesfully cancelled", errors: []}
      else
        {message: nil, errors: ["Not authorized to remove this ticket"]}
      end
    end
  end

end
