class CreateTestDefinitions < ActiveRecord::Migration
  def self.up
    create_table :test_definitions do |t|
      t.references :project
      t.references :previous_test_version
      t.integer    :comments_count
      t.string     :identification
      t.text       :snippet
      t.string     :testing_framework

      t.timestamps
    end
  end

  def self.down
    drop_table :test_definitions
  end
end
