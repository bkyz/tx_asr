module TxAsr
  class SentenceRecognition
    # 2 为 一句话识别
    SUB_SERVICE_TYPE = 2

    ACTION = "SentenceRecognition"

    ENG_SERVICE_TYPE_8K_ZH = "8k_zh"
    ENG_SERVICE_TYPE_16K_ZH = "16k_zh"

    def self.from(url)
      payload = common_payload.merge({ Url: url })

      Request.new(payload).call(ACTION)
    end

    def self.common_payload
      {
        ProjectId: TxAsr.project_id || TxAsr::PROJECT_ID_DEFAULT,
        SubServiceType: SUB_SERVICE_TYPE,
        EngSerViceType: ENG_SERVICE_TYPE_8K_ZH, # 这里的键名是照着文档的，是正确的
        VoiceFormat: TxAsr.voice_format,
        UsrAudioKey: voice_id
      }
    end

    def self.voice_id
      SecureRandom.uuid
    end
  end
end