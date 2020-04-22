class HomepageController < ApplicationController
  include Devise::Controllers::Helpers 

  def index
      array = Array.new
      array[0] = ['Course', 'Workload', 'TeachingQuality', 'Faculty', 'Overall']
      i = 1
      Course.all.each do |course|
          array[i] = [course.code, course.workload, course.quality, course.faculty, course.overall]
          i = i + 1
      end
      @courses = array.to_json.html_safe
  end
  
end
