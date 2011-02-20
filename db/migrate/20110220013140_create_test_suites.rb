class CreateTestSuites < ActiveRecord::Migration
  def self.up
    create_table :test_suites do |t|
      t.references :project
      t.string     :revision

      t.timestamps
    end

    create_table :test_definitions_test_suites, :id => false do |t|
      t.references :test_definition
      t.references :test_suite
    end

  end

  def self.down
    drop_table :test_suites
  end
end
