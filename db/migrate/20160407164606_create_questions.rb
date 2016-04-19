# This file doesn't automatically make the table, it just specifies what the table will look like when you run the command bin/rake db:migrate
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      # The :id field is automatic so you dont have to make it manually
      t.string :title
      t.text :body

      # timestamps will add two extra fields: created_at and updated_at
      # they will be of type datetime and be automatically set by active record
      t.timestamps null: false
    end
  end
end
