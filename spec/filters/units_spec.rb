# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/units"

describe LogStash::Filters::Units do
  describe "special field" do
    let(:config) do <<-CONFIG
      filter {
        units {
          fields => ["[a1][a2]", "b1", "c1", "d2"]
          input_unit => "byte"
          output_units => ["kibibyte", "mebibyte"]
          root_field => "special"
          rename_labels => {
            "kibibyte" => "kb"
            "mebibyte" => "mb"
          }
        }
      }
    CONFIG
    end

    event = {
        "a1" => {
          "a2" => 1024
          },
        "b1" => 1024,
        "c1" => 1024,
        "d1" => {
          "d2" => 1024
          }
        }
    sample(event) do
      insist { subject["special"]["a1"]["a2"]["kb"] } == 1
      insist { subject["special"]["a1"]["a2"]["kb"] } == 1
      insist { subject["special"]["b1"]["kb"] } == 1
      insist { subject["special"]["c1"]["kb"] } == 1
      insist { subject["special"]["d1"]["d2"]["kb"] } == 1
    end
  end

  describe "in place" do
    let(:config) do <<-CONFIG
      filter {
        units {
          fields => ["[a1][a2]", "b1", "c1", "d2"]
          input_unit => "byte"
          output_units => ["kibibyte", "mebibyte"]
          rename_labels => {
            "kibibyte" => "kb"
            "mebibyte" => "mb"
          }
        }
      }
    CONFIG
    end

    event = {
        "a1" => {
          "a2" => 1024**2
          },
        "b1" => 1024**2,
        "c1" => 1024**2,
        "d1" => {
          "d2" => 1024**2
          }
        }
    sample(event) do
      insist { subject["a1"]["a2"]["mb"] } == 1
      insist { subject["b1"]["mb"] } == 1
      insist { subject["c1"]["mb"] } == 1
      insist { subject["d1"]["d2"]["mb"] } == 1
    end
  end
end
