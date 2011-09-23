Feature: Search
  In order to copy bundle command to my clipboard
  As user using cpgem
  I want to use the simple command

  Scenario: Search gem googl
    When I run "cpgem googl"
    Then the output should contain exactly:
      """
      bundler: gem "googl", "~> 0.5.0"
      install: gem install googl
      name: googl
      version: 0.5.0
      3166 downloads
      804 for this version
      homepage: http://github.com/zigotto/googl

      """

  Scenario: Searching an invalid name
    When I run "cpgem blebleble"
    Then the output should contain:
          """
          Gem not found :(
          """

  Scenario: Do not copy bundler command
