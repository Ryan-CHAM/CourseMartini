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
      
      yarra = Array.new
      yarra[0] = ['Course Code', 'Teaching Qulity', 'Workload', 'Usefulness', 'Difficulty', 'CGPA', 'Overall']
      i = 1
      Course.all.each do |course|
          yarra[i] = [course.code, course.quality, course.workload, course.usefulness, course.difficulty, course.gpa, course.overall]
          i = i + 1
      end
      @sesruoc = yarra.to_json.html_safe
  end
  
end
