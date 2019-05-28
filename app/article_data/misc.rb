# The APOD API's endpoint takes a 'start date' and an 'end date' (yy-mm-dd).
# We generate data collected in the last 1 year to bring the latest data into view
def get_start_date
  date = Time.new
  year = date.year
  month = date.month < 10 ? "0" + date.month.to_s : date.month
  day = date.day < 10 ? "0" + date.day.to_s : date.day
  start_date = "#{year-2}-#{month}-#{day}"
  start_date
end

def get_end_date
  date = Time.new
  year = date.year
  month = date.month < 10 ? "0" + date.month.to_s : date.month
  day = date.day < 10 ? "0" + date.day.to_s : date.day
  end_date = "#{year-1}-#{month}-#{day}"
  end_date
end

def get_apod_json
  start_date = get_start_date
  end_date = get_end_date

  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep&start_date=#{start_date}&end_date=#{end_date}"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)
  json = JSON.parse(data)
  json
end

def misc_data
  apod_json = get_apod_json
  json = read_hash
  misc_elements = []

  apod_json.each do |el|
    misc_data = {}
    misc_data["title"] = el["title"]
    misc_data["date"] = el["date"]
    misc_data["overview"] = el["explanation"]
    misc_data["curated"] = false
    misc_elements << misc_data
  end

  json["misc"] = misc_elements

  write_to_json(json)
end

misc_data
