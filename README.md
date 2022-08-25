Technical test Ruby on Rails
Task: develop a clone of airbnb.
The main priority was the development of a booking system, search places by multiple params (including booking days). Also there was task to separating host-guest abilities.

Technologies: 
- ruby 2.7.0
- rails 6
- Rubocop for code quality
- postgresql
- devise for authentication
- Rspec

Result.

done features:
- Places management. Users can create adverts and delete it (User can delete advert if he is owner).
- Booking system with strong validations.
- Booking management.
- Ability to search adverts by multiple parameters at the same time (Region, property type, max guests, max price per day, booking dates).
- authentication by devise.
- separate actions and views for hosts and guests.
- in my opinion, a convenient and understandable interface
- started with tests a little.

To do:
- Move interface to React.
- Add admin role to User model.
- Add photos to adverts using active storage or carrierWave.
- Cover all features with tests.
- Add verify system for adverts.
