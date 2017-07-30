class QiniuConfig
  class << self

    def full_url(url)
      return 'http://ot43ftdun.bkt.clouddn.com/' + url
    end

    def upload(path,name)
      # 要上传的空间
      bucket = 'walkthebaby'
      # 上传到七牛后保存的文件名
      key = name
      # 构建上传策略，上传策略的更多参数请参照 http://developer.qiniu.com/article/developer/security/put-policy.html
      put_policy = Qiniu::Auth::PutPolicy.new(
          bucket, # 存储空间
          key,    # 指定上传的资源名，如果传入 nil，就表示不指定资源名，将使用默认的资源名
          3600    # token 过期时间，默认为 3600 秒，即 1 小时
      )
      # 生成上传 Token
      uptoken = Qiniu::Auth.generate_uptoken(put_policy)
      # 要上传文件的本地路径
      filePath = path
      # 调用 upload_with_token_2 方法上传
      code, result, response_headers = Qiniu::Storage.upload_with_token_2(
          uptoken,
          filePath,
          key,
          nil, # 可以接受一个 Hash 作为自定义变量，请参照 http://developer.qiniu.com/article/kodo/kodo-developer/up/vars.html#xvar
          bucket: bucket
      )
      #上传返回的信息
      {code: code,result: result}
    end

    def delete_file(key)

      # 要删除的存储空间，并且这个资源名在存储空间中存在
      bucket = 'walkthebaby'
      key = key
      # 删除资源
      code, result, response_headers = Qiniu::Storage.delete(
          bucket,     # 存储空间
          key         # 资源名
      )
      {code: code,result: result}
    end



  end
end