module Mutations
  class Register < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, [String], null: true

    def resolve (email:, password:, password_confirmation:)
      if password != password_confirmation
        return {user: nil, token: nil, errors: ["Passwords do not match"]}
      end

      user = User.new(email: email, password: password, password_confirmation: password_confirmation)

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        {user: user, token: token, errors: []}
      else
        { user: nil, token: nil, errors: user.errors.full_messages}
      end
    end
  end

end
