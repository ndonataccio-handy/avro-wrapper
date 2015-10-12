require './lib/avro_wrapper'

$schema = <<-SCHEMA
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

class ProductShowEvent < AvroWrapper
  attr_accessor :id, :current_user_id, :ab_cookie, :session_id
  def self.schema_doc
    $schema
  end
end

klass = Class.new(AvroWrapper) do
  attr_accessor :id, :current_user_id, :ab_cookie, :session_id
  def self.schema_doc
    $schema
  end
end

RSpec.describe AvroWrapper, "#use" do
  context "on simple use" do
    it "will encode and decode correctly" do
      pse = ProductShowEvent.new(id: 12, current_user_id: 231321321, ab_cookie: 12, session_id:"da8a9898a9d8d8d898a")
      result = ProductShowEvent.from_avro_string(pse.to_avro_string)
      expect(pse.to_h).to eq result.to_h
    end
  end

  context "class is dynamically created" do
    it "will encode and decode correctly" do
      pse = klass.new(id: 12, current_user_id: 231321321, ab_cookie: 12, session_id:"da8a9898a9d8d8d898a")
      result = klass.from_avro_string(pse.to_avro_string)
      expect(pse.to_h).to eq result.to_h
    end
  end
end
