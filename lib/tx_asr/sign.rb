
require 'digest'
require 'json'
require 'net/http'
require 'time'
require 'openssl'

module TxAsr
  class Sign
    attr_accessor :file_url

    SERVICE = 'asr'

    HOST = "asr.tencentcloudapi.com"

    # 加密算法
    ALGORITHM = 'TC3-HMAC-SHA256'

    # 场景模型
    ENGINE_MODEL = "16k_zh_video"

    # 声道数
    CHANNEL_NUM = 1

    # 结果回调地址
    CALLBACK_URL = "https://demo.mini-geek.com/speech_to_text/callback"

    # 声音文件来源: url
    AUDIO_SOURCE_FROM_URL = 0

    # 声音文件来源: 请求体
    AUDIO_SOURCE_FROM_BODY = 1

    # 过滤语气词: 部分
    FILTER_INTERJECTION_PART = 1

    # 过滤语气词: 所有
    FILTER_INTERJECTION_ALL = 2

    # 翻译的结果具体到单词时间，并返回语速
    RESULT_FORMAT_WORDS_WITH_PUNC = 2

    # def initialize(file_url)
    #   @file_url = file_url
    # end

    def initialize(payload)
      @payload = payload
    end

    def authorization
      signature = sign(@payload)

      date = Time.at(timestamp).utc.strftime('%Y-%m-%d')

      credential_scope = date + '/' + SERVICE + "/tc3_request"
      signed_headers = 'content-type;host'
      "#{ALGORITHM} Credential=#{TxAsr.secret_id}/#{credential_scope}, SignedHeaders=#{signed_headers}, Signature=#{signature}"
    end

    private

    def logger
      @logger ||= Logger.new Rails.root.join("log/speech_to_text.log")
    end

    def payload
      {
        EngineModelType: ENGINE_MODEL,
        ChannelNum: CHANNEL_NUM,
        ResTextFormat: RESULT_FORMAT_WORDS_WITH_PUNC,
        SourceType: AUDIO_SOURCE_FROM_URL,
        CallbackUrl: CALLBACK_URL,
        Url: file_url
      }
    end

    def sign(payload)
      http_request_method = 'POST'
      canonical_uri = '/'
      canonical_querystring = ''
      canonical_headers = "content-type:application/json; charset=utf-8\nhost:#{HOST}\n"
      signed_headers = 'content-type;host'

      hashed_request_payload = Digest::SHA256.hexdigest(payload.to_json)
      canonical_request = [
        http_request_method,
        canonical_uri,
        canonical_querystring,
        canonical_headers,
        signed_headers,
        hashed_request_payload,
      ].join("\n")

      date = Time.at(timestamp).utc.strftime('%Y-%m-%d')

      credential_scope = date + '/' + SERVICE + '/tc3_request'
      hashed_request_payload = Digest::SHA256.hexdigest(canonical_request)
      string_to_sign = [
        ALGORITHM,
        timestamp.to_s,
        credential_scope,
        hashed_request_payload,
      ].join("\n")

      digest = OpenSSL::Digest.new('sha256')
      secret_date = OpenSSL::HMAC.digest(digest, 'TC3' + TxAsr.secret_key, date)
      secret_service = OpenSSL::HMAC.digest(digest, secret_date, SERVICE)
      secret_signing = OpenSSL::HMAC.digest(digest, secret_service, 'tc3_request')
      OpenSSL::HMAC.hexdigest(digest, secret_signing, string_to_sign)
    end

    private

    def timestamp
      @timestamp ||= Time.current.to_i
    end
  end
end