class Post < ApplicationRecord
	belongs_to :user
	has_many :votes
	def self.get_all_posts(page)
		Post.paginate_by_sql("Select * from posts where lock_version<>-1 order by id desc",:page=>page,:per_page=>10)
	end
	def self.get_users_all_posts(page,user)
		Post.paginate_by_sql("Select * from posts where lock_version<>-1 and user_id=#{user.id} order by id desc",:page=>page,:per_page=>10)
	end
end
