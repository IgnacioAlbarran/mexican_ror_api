# MEXICAN CODE CHALLENGE:

Click here to see the [challenge description](https://gist.github.com/davidrv/ec4e85f0579746ab2ebeb4590577ef58)


This is a project for a JSON-api that reads and updates information about a local business called “The Original Mexican Burrito”, in different platforms via its corresponding API.

We will be using Postgres as a db.

For testing we use RSpec, plus Shoulda matchers, and for the factories and its content factory-bot and ffaker.

## Endpoints

     Prefix Verb            URI Pattern                Controller#Action
     
     venues GET           /venues(.:format)           venues#index
            POST          /venues(.:format)           venues#create
     venue GET            /venues/:id(.:format)       venues#show
           PATCH          /venues/:id(.:format)       venues#update
           PUT            /venues/:id(.:format)       venues#update
           DELETE         /venues/:id(.:format)       venues#destroy
    platform_a_data GET   /platform_a_data(.:format)  venues#platform_a_data
    platform_b_data GET   /platform_b_data(.:format)  venues#platform_b_data
    platform_c_data GET   /platform_c_data(.:format)  venues#platform_c_data

