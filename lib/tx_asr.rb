require "tx_asr/version"
require "tx_asr/railtie"
require "tx_asr/service_result"
require "tx_asr/request"
require "tx_asr/sign"
require "tx_asr/sentence_recognition"

module TxAsr
  # 声道
  SINGLE_CHANNEL = 1
  DOUBLE_CHANNEL = 2

  # 语音来源
  SOURCE_TYPE_URL = 0
  SOURCE_TYPE_BODY = 1

  ENDPOINT = "https://asr.tencentcloudapi.com"
  API_HOST = "asr.tencentcloudapi.com"

  # api 版本
  API_VERSION = "2019-06-14"

  # 音频格式
  VOICE_FORMAT_MP3 = "mp3"
  VOICE_FORMAT_WAV = "wav"

  PROJECT_ID_DEFAULT = 0


  # Your code goes here...
  mattr_accessor :secret_id,
                 :secret_key,
                 :voice_format,
                 :project_id,
                 :version,
                 :source_type,
                 :api_host,
                 :channel_num,
                 :region,
                 :filter_model

  def self.setup
    yield self if block_given?
  end
end
