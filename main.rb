require 'json'

class SearchEngine
  file = File.open "data.json"
  @data = JSON.load file

  def self.search(search_key)
    @result = []
    p_match = @data.select{ |a| a["Name"] == search_key}
    return p_match if p_match.length == 1
    perfect_match(search_key)
    type_search(search_key)
    designed_by_search(search_key)
    key = search_key.delete(' ').split('--')
    negative_search(key[0], key[1]) if search_key.include?('--')
    @result.uniq
  end

  def self.perfect_match(search_key)
    search_by('Name', search_key)
    if search_key.split(' ').length == 2
      vice_versa = search_key.split.reverse.join(' ')
      search_by('Name', vice_versa)
    end
    @result
  end

  def self.type_search(search_key)
    search_by("Type", search_key)
  end

  def self.designed_by_search(search_key)
    case search_key.split(' ').length
      when 1
        search_by('Designed by', search_key)
      when 2
        search_key = search_key.split(' ')[1]
        search_by('Designed by', search_key)
      when 3
        search_key = search_key.split[1] + ' ' + search_key.split[2]
        search_by('Designed by', search_key)
    end
  end

  def self.negative_search(search_key, but_not_type)
    @result << @data.select{ |a| a['Designed by'].downcase.match(search_key.downcase) && !a["Type"].downcase.match(but_not_type.downcase)}
  end

  private
  def self.search_by(search_field, key)
    key = key.downcase.gsub(/[^\w ]/, '')
    @result << @data.select{ |a| a[search_field].downcase.match(key)}
  end
end




puts  SearchEngine.search('Lisp Common')
puts  SearchEngine.search('Common Lisp')
puts  SearchEngine.search('Interpreted "Thomas Eugene"')
puts  SearchEngine.search('BASIC')
puts  SearchEngine.search('basic')
puts  SearchEngine.search('john --array')
