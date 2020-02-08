GraphQL-Yelp-Search

This app utilizes GraphQL to query data from Yelp about businesses according to the entered fields.

It utilizes MVVM and Redux style architecture, SwiftUI and Combine to manage data and display results to the user.

Things to Improve:

1. Improve how images are loaded and displayed.  
Currently we load 10 results and their images, then display to the user.
Images should be loaded concurrent with the UI displaying to reduce wait time for the user.
---Status: COMPLETE---

2. Add loader when network calls are made to indicate work being done to the user.  
Currently the search button is disabled and background color opacity set to 0.5 when searching.
There should be more indication to the user that a request for data has been made.
---Status: COMPLETE---

3. Explore 3rd party libraries to help manage GraphQL Queries.
What I currently have is an attempt to simplify the request and parse process.
I'd be interested to see what other solutions are out there.
---Status: PENDING---
I looked at GraphQLSwift and ApolloGraphQL but didn't spend enough time researching the support for both.
If I'm going to use a 3rd party library I want to make sure it was well supported and easy to use.
