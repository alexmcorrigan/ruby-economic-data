require "rexml/document"

class Country
  attr_reader :name, :population, :inflation_rate
  
  def initialize(world, element)
    @name = element.attributes['name']
    @population = element.attributes['population'].to_i
    @inflation_rate = element.attributes['inflation'].to_f
    in_continent = element.attributes['continent']
    continent = world.continents.find { |c| c.name == in_continent }
    continent.countries.push self
  end
  
end

class Continent
    attr_reader :name, :countries

    def initialize(element)
        @countries = []
        @name = element.attributes['name']
    end

end

class World
    attr_reader :continents

    def initialize(worldFile)
        @continents = []
        doc = REXML::Document.new worldFile
        doc.elements.each("cia/continent") { |element| @continents.push Continent.new(element) }
        doc.elements.each("cia/country") { |element| Country.new(self, element) }
    end

    def all_countries
        countries = []
        @continents.each { |c| countries.push(*c.countries) }
        return countries
    end

    def find_continent(continent)
        @continents.find { |c| c.name == continent }
    end

    def countryWithLargestPopulation
        all_countries.max { |a,b| a.population <=> b.population }
    end

    def highest_inflation_rate(top)
        all_countries.sort_by(&:inflation_rate).reverse
    end
end
