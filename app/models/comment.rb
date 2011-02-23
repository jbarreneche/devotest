class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true

end

# == Schema Information
#
# Table name: comments
#
#  id              :integer         not null, primary key
#  comentable_id   :integer
#  comentable_type :string(255)
#  comment         :text
#  created_at      :datetime
#  updated_at      :datetime
#

