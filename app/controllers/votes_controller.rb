class VotesController < ApplicationController
	def vote_post
		@vote_count=Vote.vote_unvote_post(params[:post_id],current_user)
		render partial: 'votes/vote_redirection.js.erb', locals:{post_id:params[:post_id]}
	end
end
