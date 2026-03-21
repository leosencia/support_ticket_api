module Mutations
  class Logout < BaseMutation
    field :message, String, null: false
    field :errors, [String], null: false

    def resolve
      if context[current_user]
        {message: "Logged out successfully", errors: []}
      else
        {message: "", errors: ["Not logged in"]}
      end
    end
  end
end
