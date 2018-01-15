FactoryBot.define do
  factory :strain do
    name 'tyler'
    race 'sativa'
    flavours ['earthy', 'blueberry', 'candy']
    # effects {|effect| [effect.association(:effect)]}
  end
end
