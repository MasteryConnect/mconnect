module Mconnect
  class Worker
    attr_accessor :content

    def initialize access_token, endpoint
      @content      = []
      @access_token = access_token
      @endpoint     = endpoint
    end

    def get_content page_number = 1
      url = "/api/#{@endpoint}?page=#{page_number}"

      content << JSON.parse(@access_token.get(url, 'x-li-format' => 'json').body)
      content.flatten!

      if content.count < page_number * 1000
        return content
      else
        puts "Getting page #{page_number}.."
        get_content (page_number + 1)
      end
    end
  end
end
