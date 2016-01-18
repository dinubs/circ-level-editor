class Aws::Uploader
  def self.upload file_name
    s3 = AWS::S3.new
    aws_object = s3.buckets["circ-images"].objects[file_name]
    aws_object.write(:file => file_name)
    aws_object.acl = :public_read
    File.delete(file_name)
  end
end