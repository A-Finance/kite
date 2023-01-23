# Kite

## Login Flow  

  1) [] Explore scripebox client.  
    - [] How to use a client in phoenix.
    - [] Login flow: check github as documentation is not available.

  2) [] How to structure auth flow in phoenix.  

  3) Setup api_secret keys as env variables and take it from there.

### Questions i have regarding login flow:

  1) so user has to have an account in zerodha to use our application?   
  - Ans: Without having an account in zerodha, its not possible to build as we are not solving the kyc process, legal processes etc that a person needs to start trading.

  2) Why api_secret key?
  - Ans: Its for zerodha to distinguish us( A+ finance) as an organization from other organizations and set a limit on requests. This key as nothing to do with user authentication key, which i was cconfused with, here both are not same( even name is api_secret key 🤦‍♂️)

  3) We are not handling signup of user ?

### Login flow:

  1) User makes request to A+ finance to login.
  2) A+ finance makes request/redirects to zerodha api with A+ finance api_key, https://kite.zerodha.com/connect/login?v=3&api_key=xxx.
  3) A successful login in zerodha by user comes back with a request_token to the registered redirect URL (A+ finance).
  4) POST the request_token and checksum (SHA-256 of api_key + request_token + api_secret) to /session/token.
  5) Obtain the access_token from the request made in 4th step and use that with all subsequent requests.  

  - NOTE: Once the authentication is complete, all requests should be signed with the HTTP Authorization header with token as the authorisation scheme, followed by a space, and then the api_key:access_token combination. For example:

  curl -H "Authorization: token api_key:access_token"  
  curl -H "Authorization: token xxx:yyy"  

### How i have to code:

1) Get request is made. I redirect user.