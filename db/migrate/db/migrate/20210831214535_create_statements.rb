class CreateStatements < ActiveRecord::Migration[6.1]
    def change
      create_table :statements do |t|
        t.references :po
        t.string :type
  
        t.timestamps
      end
    end
  end
  