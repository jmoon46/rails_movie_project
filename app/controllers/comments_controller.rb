class CommentsController < ApplicationController
	before_action :authentication_required
	before_action :user_info

	def create
		#raise params.inspect
		if params.include?(:movie_id)
			@movie = Movie.find_by(id: params[:movie_id])
			@comment = @movie.comments.new(comment_params)
			@comment.user = user_info
			if @comment.save
			# redirect_to movie_path(@movie)
				render 'comments/show', layout: false
			end
		elsif params.include?(:actor_id)
			@actor = Actor.find_by(id: params[:actor_id])
			@comment = @actor.comments.new(comment_params)
			@comment.user = user_info
			@comment.save
			redirect_to actor_path(@actor)
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
