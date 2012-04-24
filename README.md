# CounterCache

Counter cache module for Mongoid with Resque integration.

## Usage

Begin with including Mongoid::CounterCache inside your model:

    class Project
      include Mongoid::Document
      include Mongoid::CounterCache
    end

Specify on which model the counter cache field will exist on using the `counter_cache` method:

    counter_cache :user

Then add the required field to the `User` model:

    class User
      include Mongoid::Document
      field :projects_count, type: Integer, default: 0
    end

It should look something like this:

    class Project
      include Mongoid::Document
      include Mongoid::CounterCache
      counter_cache :user
    end

    class User
      include Mongoid::Document
      field :projects_count, type: Integer, default: 0
    end

