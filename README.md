67-272: Baking Factory
---
This is the repository for CJ's final course project in 67-272: Application Design and Development.

To set this up, clone this repository, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data, you can run the `rake db:populate` command.  The populate script will create:
- 120 customers
- over 600 orders
- a menu of 5 types of breads, 3 varieties of muffins and 1 type of pastry

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, employee-type users are fixed.  In terms of employee-type users there are two admins -- Alex (username: 'alex') and Mark (username: 'mark') -- and a shipper (username: 'shipper') and a baker (username: 'baker').  All customers have a username which is 'user' with a sequential set of numbers concatentated. (user1 - user120 should exist for you to log in as and experiment.)  All users in the system have a password of 'secret'.  

