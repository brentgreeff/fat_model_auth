ActiveRecord::Schema.define(:version => 20090628014113) do

  create_table "articles", :force => true do |t|
    t.string   "name"
  end
end
