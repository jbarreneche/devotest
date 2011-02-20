class CreateTestDefinitions < ActiveRecord::Migration
  def self.up
    create_table :test_definitions do |t|
      t.references :test_suite
      t.references :previous_test_version
      t.string     :identification
      t.text       :snippet

      t.timestamps
    end
  end

  def self.down
    drop_table :test_definitions
  end
end
