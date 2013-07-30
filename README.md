[![Gem Version](https://badge.fury.io/rb/axiom-memory-adapter.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/axiom-memory-adapter.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/axiom-memory-adapter.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/axiom-memory-adapter.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/axiom-memory-adapter/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/axiom-memory-adapter
[travis]: https://travis-ci.org/dkubb/axiom-memory-adapter
[gemnasium]: https://gemnasium.com/dkubb/axiom-memory-adapter
[codeclimate]: https://codeclimate.com/github/dkubb/axiom-memory-adapter
[coveralls]: https://coveralls.io/r/dkubb/axiom-memory-adapter

axiom-memory-adapter
====================

Use Axiom relations with an in-memory datastore

Examples
--------

```ruby
require 'axiom-memory-adapter'

adapter = Axiom::Adapter::Memory.new(
  customers: Axiom::Relation.new([[:id, Integer], [:name, String]]),
  orders:    Axiom::Relation.new([[:id, Integer], [:customer_id, Integer]])
)

# Insert customer data
customers = adapter[:customers]
customers.insert([[1, 'Dan Kubb']])
customers.insert([[2, 'John Doe']])

# Insert order data
orders = adapter[:orders]
orders.insert([[1, 1]])
orders.insert([[2, 1]])
orders.insert([[3, 1]])
orders.insert([[4, 2]])

# Join customers and orders
customer_orders = customers.
  rename(id: :customer_id).
  join(orders.rename(id: :order_id))

# Demonstrate writable view-like behaviour

# Insert into the join
customer_orders.insert([[3, 'Jane Doe', 5]])

# Inserts are propagated to the base relations
customers.count  # => 3
orders.count     # => 5

# Delete from a join
customer_orders.delete([[3, 'Jane Doe', 5]])

# Deletes are propagated to the base relations
customers.count  # => 2
orders.count     # => 4
```

Contributing
-------------

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

Copyright
---------

Copyright &copy; 2013 Dan Kubb. See LICENSE for details.
