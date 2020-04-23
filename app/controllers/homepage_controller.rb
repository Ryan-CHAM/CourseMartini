class HomepageController < ApplicationController
  include Devise::Controllers::Helpers 
  
  def overview
      
      if Comment.all.size>3
        @comments = Comment.last(3)
      else
        @comments = Comment.all
      end


      array = Array.new
      array[0] = ['Course', 'Workload', 'TeachingQuality', 'Faculty', 'Overall']
      i = 1
      Course.all.each do |course|
          array[i] = [course.code, course.workload, course.quality, course.faculty, course.overall]
          i = i + 1
      end
      @courses = array.to_json.html_safe
      
      array2 = Array.new
      array2[0] = ['Course Code', 'Teaching Qulity', 'Workload', 'Usefulness', 'Difficulty', 'CGPA', 'Overall']
      i = 1
      Course.all.each do |course|
          array2[i] = [course.code, course.quality, course.workload, course.usefulness, course.difficulty, course.gpa, course.overall]
          i = i + 1
      end
      @courses2 = array2.to_json.html_safe
  end
  
end
