class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.string :title
      t.string :file
      t.string :type
      t.integer :total_count, default: 0
      t.integer :created_count, default: 0
      t.integer :failed_count, default: 0
      t.datetime :created_at, null: false
      t.datetime :started_at
      t.integer :status, default: 0, null: false
      t.datetime :completed_at
    end
  end
end
