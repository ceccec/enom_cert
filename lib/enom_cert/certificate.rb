module Enom::Cert
  class Certificate
    # include HTTParty
    
    attr_reader :attributes, :cert_id, :domain, :validity_period, :order_date, :config_date, :renewal_indicator, :web_server_type_id, :web_server_type_name, :web_server_type_code,
      :order_id, :order_detail_id, :expiration_date, :approver_email, :message, :cert_status_id, :cert_status, :cert_status_detail, 
      :prod_type, :prod_desc, :csr, :reference_id, :ssl_certificate, :contact_type_org_name, :contact_type_job_title, :contact_type_f_name, :contact_type_l_name, 
      :contact_type_address_1, :contact_type_address_2, :contact_type_city, :contact_type_state_province, :contact_type_state_province_choice, :contact_type_postal_code,
      :contact_type_country, :contact_type_phone, :contact_type_fax, :contact_type_email_address, :contact_type_phone_ext
    alias_method :id, :cert_id

    def initialize(attributes)
      @cert_id = attributes["CertID"]
      @domain = attributes["DomainName"]
      @validity_period = attributes["ValidityPeriod"]
      @order_date = Date.strptime(attributes["OrderDate"].split(" ").first, "%m/%d/%Y") unless attributes["OrderDate"].blank?
      @config_date = Date.strptime(attributes["ConfigDate"].split(" ").first, "%m/%d/%Y") unless attributes["ConfigDate"].blank?
      @expiration_date = Date.strptime(attributes["ExpirationDate"].split(" ").first, "%m/%d/%Y") unless attributes["ExpirationDate"].blank?
      @renewal_indicator = attributes["RenewalIndicator"]
      @web_server_type_id = attributes["WebServerTypeID"]
      @web_server_type_name = attributes["WebServerTypeName"]
      @web_server_type_code = attributes["WebServerTypeCode"]
      @order_id = attributes["OrderID"]
      @order_detail_id = attributes["OrderDetailID"]
      @approver_email = attributes["ApproverEmail"]
      @message = attributes["Message"]
      @cert_status_id = attributes["CertStatusID"]
      @cert_status = attributes["CertStatus"]
      @cert_status_detail = attributes["CertStatusDetail"]
      @prod_type = attributes["ProdType"]
      @prod_desc = attributes["ProdDesc"]
      @csr = attributes["CSR"]
      @reference_id = attributes["ReferenceID"]
      @ssl_certificate = attributes["SSLCertificate"]
      @contact_type_org_name = attributes["ContactTypeOrgName"]
      @contact_type_job_title = attributes["ContactTypeJobTitle"]
      @contact_type_f_name = attributes["ContactTypeFName"]
      @contact_type_l_name = attributes["ContactTypeLName"]
      @contact_type_address_1 = attributes["ContactTypeAddress1"]
      @contact_type_address_2 = attributes["ContactTypeAddress2"]
      @contact_type_city = attributes["ContactTypeCity"]
      @contact_type_state_province = attributes["ContactTypeStateProvince"]
      @contact_type_state_province_choice = attributes["ContactTypeStateProvinceChoice"]
      @contact_type_postal_code = attributes["ContactTypePostalCode"]
      @contact_type_country = attributes["ContactTypeCountry"]
      @contact_type_phone = attributes["ContactTypePhone"]
      @contact_type_fax = attributes["ContactTypeFax"]
      @contact_type_email_address = attributes["ContactTypeEmailAddress"]
      @contact_type_phone_ext = attributes["ContactTypePhoneExt"]
      @attributes = attributes
    end
    
    def self.all(options = {})
      response = Enom::Client.request(options.merge!("Command" => "CertGetCerts"))["interface_response"]["CertGetCerts"]["Certs"]["Cert"]
      response.map{|r|self.new(r)}
    end
    
    def self.order!(options = {})
      options.merge!("Command" => "PurchaseServices", "Service" => options["prod_code"], "NumYears" => options["num_years"])
      response = Enom::Client.request(options)["interface_response"]
      self.new(response)
    end
    
    def self.find(options = {})
      options.merge!("Command" => "CertGetCertDetail", "CertID" => options["id"]||options["certid"], "NumYears" => options["num_years"])
      response = Enom::Client.request(options)["interface_response"]["CertGetCertDetail"]
      self.new(response)
    end
    
    def parse_csr
      csr = OpenSSL::X509::Request.new 
    end
  end
end