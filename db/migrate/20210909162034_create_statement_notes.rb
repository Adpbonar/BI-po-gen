class CreateStatementNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :statement_notes do |t|
      t.text :terms
      t.text :notes
      t.references :statement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
