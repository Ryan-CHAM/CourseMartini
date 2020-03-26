require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "creating a Course" do
    visit courses_url
    click_on "New Course"

    fill_in "Code", with: @course.code
    fill_in "Description", with: @course.description
    fill_in "Difficulty", with: @course.difficulty
    fill_in "N comments", with: @course.n_comments
    fill_in "Name", with: @course.name
    fill_in "Overall", with: @course.overall
    fill_in "Quality", with: @course.quality
    fill_in "Subject", with: @course.subject
    fill_in "Usefulness", with: @course.usefulness
    fill_in "Workload", with: @course.workload
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "updating a Course" do
    visit courses_url
    click_on "Edit", match: :first

    fill_in "Code", with: @course.code
    fill_in "Description", with: @course.description
    fill_in "Difficulty", with: @course.difficulty
    fill_in "N comments", with: @course.n_comments
    fill_in "Name", with: @course.name
    fill_in "Overall", with: @course.overall
    fill_in "Quality", with: @course.quality
    fill_in "Subject", with: @course.subject
    fill_in "Usefulness", with: @course.usefulness
    fill_in "Workload", with: @course.workload
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "destroying a Course" do
    visit courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course was successfully destroyed"
  end
end
