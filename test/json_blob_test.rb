require "test_helper"

class JSONBlobTest < Minitest::Test
  test "dumps blob" do
    encoded = JSONBlob.dump(a: 1)
    decoded = JSON.parse(Base64.strict_decode64(encoded))

    assert_equal decoded["a"], 1
  end

  test "loads blob" do
    encoded = Base64.strict_encode64(JSON.dump(a: 1))
    decoded = JSONBlob.parse(encoded)

    assert_equal decoded["a"], 1
  end

  test "creates json blob tag" do
    expected = %[<script data-name="user" type="application/json;base64">eyJuYW1lIjoiSm9obiBEb2UifQ==</script>]
    rendered = render_template

    assert_equal expected, rendered
  end

  test "returns safe html" do
    rendered = render_template

    assert rendered.html_safe?
  end

  test "uses custom JSON engine" do
    JSONBlob.json_engine.tap do |prev|
      custom_json_engine = Module.new do
        def self.dump(data)
          JSON.dump(data.merge(dump: true))
        end

        def self.parse(data)
          JSON.parse(data).merge("parse" => true)
        end
      end

      JSONBlob.json_engine = custom_json_engine

      encoded = JSONBlob.dump(a: 1)
      decoded = JSONBlob.parse(encoded)

      assert_equal 1, decoded["a"]
      assert decoded["dump"]
      assert decoded["parse"]

      JSONBlob.json_engine = prev
    end
  end

  private def render_template
    ApplicationController.render(inline: "<%= json_blob(:user, @user) %>",
                                 assigns: {user: {name: "John Doe"}},
                                 layout: false)
  end
end
