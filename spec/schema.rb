# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_090_628_014_113) do
  create_table 'articles', force: true do |t|
    t.string 'name'
  end
end
