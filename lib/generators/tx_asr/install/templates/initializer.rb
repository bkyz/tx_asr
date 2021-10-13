
TxAsr.setup do |config|

  # TODO 需要将 secret_key 和 secret_id 改为你实际项目中的配置
  config.secret_key = "your_secret_key"
  config.secret_id = "your_secret_id"
  config.region = "ap-guangzhou"


  # 声音格式： 支持 mp3 和 wav
  config.voice_format = "mp3"

  # 可在腾讯云后台查看。如果没有新建项目，那就是使用的默认项目，默认项目 id 为 0
  config.project_id = 0

  # API 版本号，截止 gem 发布前，下面的值为文档给出的值
  config.version = "2019-06-14"

  # source type —— 语音来源： 可选 0: url, 1: post body
  config.source_type = 0

  # 过滤语气词： 0 不过滤，1 部分过滤，2 严格过滤
  config.filter_model = 1

  # 默认声道数： 1 为单声道，2 为双声道，默认为单声道
  # config.channel_num = 1

end