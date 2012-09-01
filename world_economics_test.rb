require 'test/unit'
require './world_economics'

class EcoTest < Test::Unit::TestCase
    def setup
        @world = World.new(File.new("./resources/cia-1996.xml"))
    end

    def test_all_countries_loaded_from_file
        assert_equal 260, @world.all_countries.length
    end

    def test_find_country_with_maximum_population
        assert_equal "China", @world.countryWithLargestPopulation.name
        assert_equal 1210004956, @world.countryWithLargestPopulation.population
    end

    def test_find_countries_with_top_five_inflation_rates
        assert_country_with_inflation_rate "Belarus", 244.0, @world.highest_inflation_rate(5)[0]
        assert_country_with_inflation_rate "Turkey", 94.0, @world.highest_inflation_rate(5)[1]
        assert_country_with_inflation_rate "Azerbaijan", 85.0, @world.highest_inflation_rate(5)[2]
        assert_country_with_inflation_rate "Malawi", 83.3, @world.highest_inflation_rate(5)[3]
        assert_country_with_inflation_rate "Yemen", 71.3, @world.highest_inflation_rate(5)[4]
    end

    def test_all_continents_loaded_from_file
        assert_equal 6, @world.continents.length
    end

    def test_countries_assigned_to_continents
        assert_equal 49, @world.find_continent("Europe").countries.length
        assert_equal 59, @world.find_continent("Asia").countries.length
        assert_equal 39, @world.find_continent("North America").countries.length
        assert_equal 33, @world.find_continent("Australia/Oceania").countries.length
        assert_equal 15, @world.find_continent("South America").countries.length
        assert_equal 65, @world.find_continent("Africa").countries.length
    end

    def assert_country_with_inflation_rate(expected_name, expected_rate, country)
        assert_equal expected_name, country.name
        assert_equal expected_rate, country.inflation_rate
    end

end
