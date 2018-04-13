$(document).on "turbolinks:load", ->
  $('[type=file]').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(stl)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('[type=file]').append(data.context)
        $('.progress').slideToggle('fast')
        data.submit()
      else
        alert("#{file.name} is not a stl file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
        $('.bar').css('width', progress + '%')
        console.log(progress + '%')
