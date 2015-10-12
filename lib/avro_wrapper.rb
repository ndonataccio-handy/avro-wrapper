require 'avro'

class AvroWrapper
  def initialize(args={})
    args.each {|k,v| send("#{k}=",v)}
  end

  def self.schema_doc
    "NOT INITIALIZED"
  end

  def schema_doc
    self.class.schema_doc
  end

  def to_h
    Hash[instance_variables.map do |k|
      [k.to_s.gsub(/^@/,""),instance_variable_get(k.to_s)]
    end]
  end

  def to_avro_string
    schema = Avro::Schema.parse(schema_doc)
    dw = Avro::IO::DatumWriter.new(schema)
    buffer = StringIO.new("".force_encoding("BINARY"))
    encoder = Avro::IO::BinaryEncoder.new(buffer)
    dw.write(self.to_h,encoder)
    buffer.string
  end

  def self.from_avro_string(str)
    schema = Avro::Schema.parse(schema_doc)
    raw_data = StringIO.new(str)
    decoder = Avro::IO::BinaryDecoder.new(raw_data)
    datum_reader = Avro::IO::DatumReader.new(schema)
    object_hash = datum_reader.read(decoder)
    self.new(object_hash)
  end
end
