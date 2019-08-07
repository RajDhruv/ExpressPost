class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :post
	default_scope { where("lock_version<>-1") }

	def self.vote_unvote_post(post_id,user)
		user_vote=Vote.where("post_id=#{post_id} and user_id=#{user.id} and lock_version<>-1").last
		if user_vote.nil?
			Vote.create(post_id:post_id, user_id:user.id, lock_version:1)
		else
			ActiveRecord::Base.lock_optimistically = false
			user_vote.update_attribute("lock_version",-1)
			ActiveRecord::Base.lock_optimistically = true
		end
		Vote.where("post_id=#{post_id} and lock_version<>-1").length
	end
end
