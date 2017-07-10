'use strict';

const co       = require('co');
const AWS      = require('aws-sdk');
const Promise  = require('bluebird');
const dynamodb = Promise.promisifyAll(new AWS.DynamoDB.DocumentClient());

/* input example:
 *  { trip_id: some_guid,
 *    depart: london,
 *    depart_at: some_date,
 *    arrive: dublin,
 *    arrive_at: some_date,
 *    hotel: holiday inn,
 *    check_in: some_date,
 *    check_out: some_date,
 *    rental: volvo,
 *    rental_from: some_date,
 *    rental_to: some_date
 *  }
 */
module.exports.handler = co.wrap(function* (input, context, callback) {
  if (input.fail_book_rental) {
    callback("Internal Server Error");
  } else {
    let req = {
      TableName: "rental_bookings",
      Item: { 
        trip_id     : input.trip_id,
        rental      : input.rental,
        rental_from : input.rental_from,
        rental_to   : input.rental_to
      }
    }
    yield dynamodb.putAsync(req);
    callback(null, "ok");
  }
});