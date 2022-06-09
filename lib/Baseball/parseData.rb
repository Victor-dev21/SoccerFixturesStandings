  require_relative './BaseballApi'
class ParseData
  def self.print_standings
  counter = 0
  response = BaseballApi.baseball_team_standings

  response["response"][0].each do |team|
    if counter == 30
      break
    else
      puts "#{team["team"]["name"]} #{team["position"]} #{team["form"]}"
    end
    counter +=1
  end
  end
end
ParseData.print_standings
