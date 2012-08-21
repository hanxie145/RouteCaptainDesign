module ApplicationHelper

  # cloudfront parallelize for smartstox-images
  def cloudfront
    urls = ["d3xhojuwd8vze.cloudfront.net", "d1lps9kfnjbug7.cloudfront.net", "dxs34sem4l3tz.cloudfront.net"]
    return "https://" + urls.sample
  end
end