# MDE 4ye

可嵌入Sinatra应用的markdown编辑器(基于ace editor和第三方图片上传服务，支持语法高亮和图片粘贴).

## 使用

在Gemfile内添加

```ruby
gem "mde-4ye", :github => "kaid/mde-4ye"
```

运行

```bash
$ bundle
```

在Sinatra应用内声明

```ruby
require "mde-4ye"
register MDE4ye
```

在需要使用的地方调用

```ruby
mdeditor("表单名", "## markdown内容")
```
