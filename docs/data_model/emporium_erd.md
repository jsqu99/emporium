Notes regarding ERD
==========================

Tables
-------

* Should be namespaced (prefixed with 'emporium_')
* Always contain id, created_at, updated_at unless noted otherwise.
* Not all of the tables shown should necessarily be included in the 'core' data model.  I wanted to make sure that 'extension' features would fit in withouth changing anything in the 'core'.  We can decide which tables are critical and which aren't at a later time.

Product Model
-------------

* *Sku* is the 'sellable product'.  Coming from a spree (rails project) background, the term variants is used there.  I personally like 'sku' better as I believe it is more descriptive.  Please opine.

* *Product* is more of a 'meta' table (you can't buy a *product*).

* Some products only have one sku (e.g. Product would be: Hershey's Peanut M&M's, 3 ounce bag)

* Some products will have multiple skus (e.g. Product would be Men's V-Neck T-shirt, skus would vary for size and color)

* In the size/color example above, the products are associated with acceptable Properties (Size, Color), and skus are differentiated by their ProductProperty.

* The three *sku customization* tables allow things like selling a product that is priced according to something complicated like length (e.g. rope), dimension (custom-made art frame), "price-per-letter" engraving.  We can discuss having these be part of an extension, but one thing to keep in mind is the whole 'add to cart' thing was a nightmare in other frameworks and required lots of surgery, so I want to think about this case up-front (customizing and pricing products both before and after adding to cart).

* *SkuAvailability* can provide for flash sales and other types of controlled-release situations

* *Store* is bare bones but I believe important.  You could have multiple-branded front ends hit the same back ends

* *PriceBooks* were a powerful feature in another project I worked on that allowed a sophisticated way to define a default set of prices and then do things like base other prices on location, currency, etc. using price overrides and multiplication factors.  There's lots of good code in the spree ecosystem that can be used as a starting point.

Promotions
-----------

* I propose we borrow a lot from how spree usese promotion rules and actions (unless there are better approaches).  That's where these tables come from

User Model
---------

* It's probably a good idea to have a configurable 'user' model so we play nicely with existing applications.

* I was thinking of having a bare-bones *Shopper* table that linked to a real 'authenticable' user.  I'm not passionate about this. It's just an idea.

There's plenty I have left out of the ERD.  What do you think of what I came up with so far?
