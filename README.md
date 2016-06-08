# Hook, Line & Sinker

HLS is a small sinatra web app that consumes incoming webhooks from a Mandrillo-like service and processes them before storing them in an easy to use format in a local postgres Database.

## Update 08/06/16
I've made a few changes since I last updated this README and project, mostly based on my initial thoughts and to-do list detailed below. The latest updates can be found on the branch `converting-to-api`. The key changes are:
* I've stripped out all views and related tests from the app in order to provide a more streamlined API, able to plug into any front end. This will eventually be merged into master.
* I finally got tests working for the routing of webhooks! It involved enabling and including Rack Test Methods to allow post and get requests directly from the rspec test steps. This resolved the issues I was having with the database.
* I added more generic API routes for the retrieval of Emails and Emails by parameter.

## Setup

1. Clone this repo
2. Create two Postgres databases, hls_test & hls_development
3. In terminal run `bundle install` to install dependencies
4. To test, run `rspec` in terminal
5. Launch with `rackup` from the terminal
6. Point your webhook provider to your racked up application (defaults to port 9292)
7. Watch your database fill up!

## Implementation & Technology
* Chose a sinatra application as I wanted to keep the app as small and lean as possible.
* Modeled my Email DB model on the incoming JSON object.
* Postgres and Datamapper were used as a database and ORM respectively due to prior experience with them.
* Front-end work was very minimal, provides the bones of a dashboard and email list
* Aimed for readability and functionality of code. Potential for refactoring before deploying.

## Challenges
* Testing webhooks was problematic. Firing HTTParty post requests as part of a test suite resulted in entries arriving in the development database rather than test. Ideally I would have liked to test that:
    * Post requests return a successful status code
    * Post requests increase the number of emails in the database by 1
    * Pulling out the last created entry in the database matches the data in the latest Post request.
* While consuming and storing the incoming webhooks was fairly straightforward, the subsequent use and display of that data was challenging and needs further work.

## App Extension

A lot of scope for interesting development of the app.
* Ultimately I'd like to turn the sinatra app into simply a web hook processor and restful API.
   * The API would be responsible for processing incoming webhooks into the database and then providing READ endpoints for calculated key metrics - open rate, click rate etc.
   * This could then be front-end tech agnostic and potentially polled by multiple other services.
* A proper front-end dashboard, possibly built with React using D3 to display key email metrics for marketing types!
* Searchable email list page and GUI to check the status of specific emails/users etc.
* Additional models for user, adding relationships so that emails belong to a certain user to allow more complex querying

## Still To-Do

* Calculate the open rate and click rate per email type
* ~~Learn how to properly test that an incoming webhook request is processed properly~~
* ~~Add data validations to the Email model so as to avoid corrupt/incorrect data~~
* Add more tests and increase test coverage!
* Get it up on Heroku
