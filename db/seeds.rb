puts "🧹 Cleaning database... blip blorp"
Ticket.destroy_all
User.destroy_all

puts "👤 Creating users... meep morp"

admin = User.create!(
  email: "admin@support.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

user1 = User.create!(
  email: "juan@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :user
)

user2 = User.create!(
  email: "maria@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :user
)

puts "✅ Created #{User.count} users... beep boop beep"

puts "🎫 Creating tickets... eee ooo eee ooo"

Ticket.create!([
  {
    subject: "Cannot login to my account",
    description: "I keep getting invalid credentials error even though I just reset my password.",
    category: :technical,
    priority: :high,
    status: :open,
    requester: user1
  },
  {
    subject: "Billing charge not reflecting",
    description: "I was charged twice for my subscription this month but my dashboard still shows unpaid.",
    category: :billing,
    priority: :critical,
    status: :in_progress,
    requester: user1,
    assigned_to: "Mark Santos"
  },
  {
    subject: "How do I export my data?",
    description: "I would like to download all my account data for personal records.",
    category: :general,
    priority: :low,
    status: :resolved,
    requester: user1,
    assigned_to: "Anna Reyes"
  },
  {
    subject: "App crashes on mobile",
    description: "Every time I open the app on my iPhone 14, it crashes immediately after the splash screen.",
    category: :technical,
    priority: :critical,
    status: :open,
    requester: user2
  },
  {
    subject: "Request for invoice copy",
    description: "I need an official invoice for my February payment for reimbursement purposes.",
    category: :billing,
    priority: :medium,
    status: :open,
    requester: user2
  },
  {
    subject: "Feature request: dark mode",
    description: "Would love to have a dark mode option. My eyes hurt using the app at night.",
    category: :other,
    priority: :low,
    status: :closed,
    requester: user2,
    assigned_to: "Anna Reyes"
  },
  {
    subject: "Password reset email not arriving",
    description: "I requested a password reset 3 times already but I never receive the email. Checked spam too.",
    category: :technical,
    priority: :high,
    status: :in_progress,
    requester: user1,
    assigned_to: "Mark Santos"
  },
  {
    subject: "Wrong plan shown on dashboard",
    description: "I upgraded to the Pro plan last week but my dashboard still shows I am on the Free plan.",
    category: :billing,
    priority: :high,
    status: :open,
    requester: user2
  }
])

puts "✅ Created #{Ticket.count} tickets... hooray!"

puts ""
puts "🎉 Seeding complete! Here are your test credentials:"
puts "-----------------------------------------------------"
puts "Admin   → admin@support.com / password123"
puts "User 1  → juan@example.com / password123"
puts "User 2  → maria@example.com / password123"
puts "-----------------------------------------------------"
