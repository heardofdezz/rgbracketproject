class CreateTournois < ActiveRecord::Migration[5.1]
  def change
    create_table :tournois do |t|
      t.json 'payload'
      t.timestamps
    end
  end
end
