class CreateProjectStatusChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :project_status_changes do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.datetime :status_updated_at, null: false

      t.timestamps
    end
  end
end
