=begin
COMMENT MODEL – Controll table of comments
PROGRAMMER: LI Jingchen
PURPOSE: Sets validation for comment construction
=end
class Comment < ApplicationRecord
	#the relation between comment and user|course is user|course has many comments, comments belong to user|course
	#when save comment, it can success if and only if the comment has paired a course and a user
	belongs_to :user, validate: true
	belongs_to :course, validate: true
end
