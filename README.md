# Ruby Avro Wrapper

## Getting Started

1. Install gem at the command prompt if you haven't yet:

        gem install avro-wrapper

or in your Gemfile

        gem 'avro-wrapper'

2. Define your own class with your own schema. For example: 

        class ProductShowEvent < AvroWrapper
          attr_accessor :id, :current_user_id, :ab_cookie, :session_id
          def self.schema_doc
            <<-SCHEMA
            {
             "type" : "record",
             "name" : "ProductShowEvent",
             "fields" : [
                          {"name": "id", "type": "int"},
                          {"name": "current_user_id", "type": "int"},
                          {"name": "ab_cookie", "type": "int"},
                          {"name": "session_id", "type": "string"}
                        ]
            }
            SCHEMA
          end
        end

3. Encode it

        event = ProductShowEvent.new(id: 12, current_user_id: 231321321, 
                  ab_cookie: 12, session_id:"da8a9898a9d8d8d898a")
        event.to_avro_string

4. Decode it

        loaded_event = ProductShowEvent.from_avro_string(event.to_avro_string)

5. Compare them

        loaded_event.to_h == event.to_h
        
