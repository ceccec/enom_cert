module Enom::Cert
  class Product
    # include HTTParty
  
    attr_reader :prod_type, :prod_code, :prod_desc, :retail_price, :reseller_price, :enabled, :years, :attributes
    alias_method :id, :prod_code
    alias_method :service, :prod_code

    def initialize(attributes)
      @prod_type = attributes["ProdType"]
      @prod_code = attributes["ProdCode"]
      @prod_desc = attributes["ProdDesc"]
      @retail_price = attributes["RetailPrice"]
      @reseller_price = attributes["ResellerPrice"]
      @enabled = attributes["Enabled"]
      @years = attributes["Years"]
      # @attributes = attributes
    end
  
    def self.all(options = {})
      response = Enom::Client.request("Command" => "GetCerts")["interface_response"]["GetCerts"]["Certs"]
      response.map {|k,v| self.new(v) }
    end
  
    def self.purchaseable(options = {})
      certs = self.all(options).map {|c|c if c.prod_code && c.enabled}
      certs.compact
    end
  end
end