# README

sluggo - allows a user to create a shortcut for any url that can then be used to access the url.


INSTALLATION
************

Clone/download the repo and run bundle install.
Run locally with rails s -p 3000
(NB: if you wish to run on a different port locally you will need to adjust the default_url_options
in the routes.rb file)


USAGE
*****

Once running you will need to login in order to be able to create a short url for a standard url.
After logging in click view ny links, you will see all links you have created a short url for, along 
with a counter showing how many times the short url has been used.
To create a new page link use 'create a new link', enter the full url and click create, you will be taken back to the page links index where the new link and it's short url will be visible.
Copy and paste the short url into any browser window and you should be taken to the relevant site.
NB: Creating a short url for an invalid url will fail.

* ...
