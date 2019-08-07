class Post < ApplicationRecord
	belongs_to :user
	has_many :votes
	def self.get_all_posts(page)
		all_post=Post.paginate_by_sql("Select * from posts where lock_version<>-1 order by id desc",:page=>page,:per_page=>10)
		count=Post.find_by_sql("Select count(*) as count from posts where lock_version<>-1").last.count
		return all_post,count
	end
	def self.get_users_all_posts(page,user)
		all_post=Post.paginate_by_sql("Select * from posts where lock_version<>-1 and user_id=#{user.id} order by id desc",:page=>page,:per_page=>10)
		count=Post.find_by_sql("Select count(*) as count from posts where lock_version<>-1 and user_id=#{user.id}").last.count
		return all_post,count
	end
end
