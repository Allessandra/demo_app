class BlogsController < ApplicationController

def home
end

def about
end

def contact
end 

def send_email
  # should send email and redirect to home page.
 redirect_to root_path, :notice => "Email sent with subject #{params['subject']} and body #{params['body']}"

end

end
