class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      # Foreign key: true automatically creates the foreign key constraint
      t.references :question, index: true, foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end
