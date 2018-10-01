# README

*Installation
To run this project locally:
1. Clone the repo to your local machine
2. Run a redis server in a separate terminal (if using osx, you can install redis via homebrew, and run with the shell command $redis-server)
3. Run a sidekiq process in a separate terminal (after installing the sidekiq ruby gem, run $bundle exec sidekiq -c 1)
4. Run the rails server with the command $rails server
5. The relevant endpoints which you can hit via the command line, or curl gui (I prefer Postman) are these:
    
    Method: POST, Body: link[url]="https://your_full_link_here" , rel_path: /api/v1/links
    
    If a valid request is sent, the response will be the shortened url: 
    e.g. response: '{"shortened_url": "http://localhost:3000/1S"}


    Method: GET, rel_path: /api/v1/links/most_popular
    
    The response will be a sorted array of the most frequently accessed urls:
    e.g. response: [{"url": "https://www.nike.com", "access_count": 121},{"url": "https://www.puma.com", "access_count": 31} ]

   
   
   
