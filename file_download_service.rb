class FileDownloadService
  attr_reader :url, :max_size, :default_path, :file_name

  def initialize(url, file_name, max_size: 100.megabytes, default_path: 'tmp/new_downloads')
    @url = url
    @max_size = max_size
    @default_path = default_path
    @file_name = file_name
  end

  def download
    FileUtils.mkdir_p(default_path)

    file_path = Rails.root.join("#{default_path}/#{file_name}#{file_extname}")

    Down.download(url, destination: file_path, max_size: max_size)
  end

  private

  def file_extname
    uri = URI.parse(url)
    filename = File.basename(uri.path)

    File.extname(filename)
  end
end

# in your Gemfile add gem 'down'
