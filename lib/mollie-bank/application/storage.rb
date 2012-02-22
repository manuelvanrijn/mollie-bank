module MollieBank
  # The Storage class for storing a key value pair (without a database)
  class Storage
    @@_storage_object = {}

    # Retrieve the value of the +key+
    #
    # @param [Object] key
    # @return [Object] value
    def self.get(key)
      return nil unless @@_storage_object.has_key?key
      @@_storage_object[key]
    end

    # Retrieve the value of the +key+
    #
    # @param [Object] key
    # @param [Object] value
    def self.set(key, value)
      @@_storage_object[key] = value
    end
  end
end
