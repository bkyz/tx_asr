
module TxAsr
  class Request
    def initialize(payload)
      @payload = default_payload.merge(payload)
      p @payload
    end

    def call(action)
      result = request(action)

      if result["Response"]["Error"].present?
        # {
        #   "Response":
        #     {
        #       "Error": {
        #           "Code": "AuthFailure.SignatureFailure",
        #           "Message": "The provided credentials could not be validated. Please check your signature is correct."
        #         },
        #       "RequestId":"ff48f384-6da7-4797-874a-b88e5e186136"
        #     }
        # }
        ServiceResult.new(errors: result["Response"]["Error"], message: result["Response"]["Error"].fetch("Message"))
      else
        # {
        #   "Response":
        #     {
        #       "RequestId": "6f24aeab-9929-4aec-81de-e3eff87639f6",
        #       "Data": {
        #         "TaskId":
        #           1357048750
        #       }
        #     }
        # }
        ServiceResult.new(success: true, data: result["Response"])
      end
    end

    private


    def default_payload
      {
        SourceType: TxAsr.source_type || TxAsr::SOURCE_TYPE_URL,
      }
    end

    def request(action)
      authorization = Sign.new(@payload).authorization
      uri = URI(TxAsr::ENDPOINT)
      req = Net::HTTP::Post.new(uri)
      req["Authorization"] = authorization
      req["Content-Type"] = "application/json; charset=utf-8"
      req["Host"] = TxAsr::API_HOST
      req["X-TC-Action"] = action
      req["X-TC-Timestamp"] = timestamp
      req["X-TC-Version"] = TxAsr.version
      req["X-TC-Region"] = TxAsr.region

      resp = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(req, @payload.to_json)
      end

      p "===="
      p JSON.parse(resp.body)
      p "===="

      if resp.is_a? Net::HTTPSuccess
        JSON.parse(resp.body).with_indifferent_access
      else
        logger.error <<-ERROR
#{resp.message}
uri: #{resp.uri}
code: #{resp.code}
#{req.each_header.inject(""){|headers, header| headers + header.join(": ") + "\n"}.rstrip}
body:
#{resp.body}
        ERROR

        raise Errors::RequestError.new(req, resp)
      end
    end

    def timestamp
      @timestamp ||= Time.current.to_i
    end
  end
end