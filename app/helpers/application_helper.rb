# Rails automatically imports this module in our other application files
# so we have access to any helper methods defined here anywhere
module ApplicationHelper

  # Here we define custom helper functions. We are trying to solve here the
  # problem of the leading '|' in our prior base title
  # Returns the full title on a per-page basis

  def full_title(page_title = '')                     # this has an optional argument. the default value is ''
    base_title = "Ruby on Rails Tutorial Sample App"  # defining a local variable
    if page_title.empty?                              # if optional argument is empty, return base title
      base_title
    else                                              # otherwise return a combination of base title and page title with " | " in between
      page_title + " | " + base_title
    end
  end

end
