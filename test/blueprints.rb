require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do |user|
  email  { "user#{sn}@example.com" }
  password  { "password#{sn}" }
  confirmed_at { Time.now }
end
