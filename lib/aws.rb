module Aws

  require 'time'
  require 'config/secrets.yml'

  # Initialiaze access to DynamoDB
  def self.init

    # Set up Client with settings from secrets.yml:
    if Rails.env.development?

      @client ||= Aws::DynamoDB::Client.new(
          endpoint: "http://localhost:8000",
          region: "localhost"
      )

    else

      @client ||= Aws::DynamoDB::Client.new(
          access_key_id: Rails.application.secrets.dynamodb_access_key_id,
          secret_access_key: Rails.application.secrets.dynamodb_secret_access_key,
          region: Rails.application.secrets.region
      )

    end

  end

  # Save records in DynamoDB table
  def self.save_items_to_my_table1(params)


    return if !@client

    resp = @client.put_item({
                                item: {
                                    "uuid" => ,
                                    "country" => params['country'],
                                    "state" => params['state'],
                                    "city" => params['city'],
                                    "landmark" => params['landmark'],
                                    "latitude"=> params['latitude'],
                                    "longitude"=> params['longitude'],
                                    "perspective" => params['perspective'],
                                    "user-id" => params['user-id'],
                                    "photo-url" =>
                                },
                                return_consumed_capacity: "TOTAL",
                                table_name: "locationsInfo",
                            })

  end

  # Get all items from DynamoDB my_table1:
  def self.get_items

    resp = @client.scan({
                            table_name: "my_table1",
                        })

    # Returns array of items:
    return resp.items

  end

end
