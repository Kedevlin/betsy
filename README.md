
#Better Wetsy

Better Wetsy integrates a shipping service API for generating shipping cost estimates, incorporating a multistep form for the orders. The shipping service API can be found at https://github.com/desireepoland/shipping-service/tree/alddfp/master. This API is not yet deployed, but feel free to fork it and try.
The sire can be viewed locally by running on the shipping-service API on localhost:3000, and using a different port for better wetsy (ex: rails server --port=3001).

BetterWetsy can be seen at: http://betterwetsy.herokuapp.com/ (however, it is not connected to the API)

The assumptions for the shipping costs are that order items from the same merchant (taking quantity into account) will be grouped into one package by the API. The shipping cost returned is the total cost to send the collection of packages from the different merchants.

To Do: Bug fix - Currently, if a valid address isn't entered, shipping is free.

# Original Wetsy
[w]Etsy is an online store where you can buy or sell any product as long as it has to do with the water. This website was built with Ruby on Rails and a lot of love by Kelly, Tammy, and Jennie. We used Agile practices (stand-up meetings, weekly demos, etc.) to create user stories to complete our project. You can see our [completed Trello board here](https://trello.com/b/mxIvtRi2/wetsy-planning).

# Accessing the website
You can view the website live at [Wetsy](https://wetsy.herokuapp.com/)

# Setting up
To set up the project:
1. Clone the project from github
2. Run bundle install
3. Run rake db:seed to seed the database
4. Run rails server and open the website on your localhost in the browser

# Applying New Concepts
We did a few new things in this project:
- model relationships: has_many, through and has_and_belongs_to_many
- building user authentication from scratch
- using the session hash to store cart and logged in user information
- before_action controller filters for determining which users could view which pages

# Fun New Gems We Used
- [FactoryGirl](https://github.com/thoughtbot/factory_girl)
- [Bullet](https://github.com/flyerhzm/bullet)
