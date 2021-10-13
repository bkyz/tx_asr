# TxAsr
Short description and motivation.

## Usage
```ruby

# sentence recognition
result = TxAsr::SentenceRecognition.from(audio_url)

if result.success?
  p result.data
end
```

## Installation
1. 在 Gemfile 里边添加如下代码

```ruby
gem 'tx_asr'
```

2. 执行 bundle

```bash
$ bundle
```

3. 执行安装命令
```bash
$ rails g tx_asr:install
```

4. 修改 `config/initializers/tx_asr.rb` 中 `secret_id` 和 `secret_key` 为实际的值


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
