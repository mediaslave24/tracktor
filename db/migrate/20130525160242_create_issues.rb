class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :body
      t.integer :assigned_to
      t.string :customer_email
      t.string :customer_name
      t.string :state

      t.timestamps
    end
  end
end
