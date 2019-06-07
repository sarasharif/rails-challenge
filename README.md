## Breazy Rails Challenge

### Setup
`bundle install`
`rake db:setup`


### Launch
`rails s`


### Tests
`rake spec`


### Using the API
#### POST to /orders
Feel free to create an order!
A user account and some stock items have already been generated for you.
##### Sample request
`POST localhost:3000/orders`

```
{
  "customer_id": 1,
  "variants": {
    "1": 2,
    "2": 1
  }
}
```

#### GET /orders/:id
View relevant order information!
But please test out the POST endpoint first :)
##### Sample request
`GET localhost:3000/orders/1`
```
{
  "date_created": "2019-06-07T07:46:37.034Z",
  "customer": {
    "id": 1,
    "name": "Lucy",
    "email": "Lucy@DogeMail.com"
  },
  "total_cost": 1020,
  "order_status": "pending",
  "items": [
    {
      "id": 1,
      "name": "Collar",
      "style": "Red",
      "price": 10,
      "quantity": 2
    },
    {
      "id": 2,
      "name": "Collar",
      "style": "Shiny Metal",
      "price": 1000,
      "quantity": 1
    }
  ]
}
```
