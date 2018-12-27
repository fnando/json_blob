require "action_view/helpers"

module JSONBlob
  module ActionView
    def json_blob(name, data)
      content = JSONBlob.dump(data)
      content_tag(:script, content, data: {name: name}, type: "application/json;base64")
    end

    ::ActionView::Helpers.include(self)
  end
end
