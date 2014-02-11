require 'net/http'

module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def get_distance(origin, destination)
    # origin = origin.split(" ").join("+")
    # destination = destination.split(" ").join("+")
    # url = URI.parse("http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&sensor=false&units=imperial")
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port) {|http|http.request(req)}
    # parsed_json = ActiveSupport::JSON.decode(res.body)
    # distance = parsed_json["rows"][0]["elements"][0]["distance"]["text"]
    # home = parsed_json["origin_addresses"][0]
    # return "#{distance} miles away from #{home}"
  end

end
