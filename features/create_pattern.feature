Feature: Create Pattern

  As a webdesigner
  I want to create pattern which is saved to a file
  In order to use it in my website

  Scenario: Svg file
    Given a pattern file named "xes1.svg" does not exist
    When I successfully run `geo_pattern --pattern xes "Mastering Markdown"`
    Then the file "xes1.svg" should contain:
    """
    asdf
    """
