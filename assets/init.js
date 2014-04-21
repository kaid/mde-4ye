if (typeof ace === "undefined") {
    var script = document.createElement("script");
    script.src="/mde-4ye/ace/ace.js";
    document.body.appendChild(script);
}

function upload(file, cb) {
    var xhr  = new XMLHttpRequest();
    var data = new FormData;
    
    if (!file.name) file.name = "image" + (new Date).valueOf() + ".png";
    data.append("file", file, file.name);

    xhr.onreadystatechange = handler;
    
    function handler() {
        if (xhr.readyState < 4)   return;
        if (xhr.status >= 400)    return;
        if (xhr.readyState === 4) cb(xhr);
    }
    
    xhr.open("POST", "http://img.4ye.me/images", true);
    xhr.send(data);
}

function image(alt, src) {
    return "[" + alt + "](" + src + ")\n";
}

window.onload = function() {
    var id     = "4ye-markdown-editor";
    var editor = ace.edit(id);
    var el     = document.getElementById(id);
    var theme  = el.getAttribute("data-theme") || "github";
    var input  = document.getElementById("4ye-markdown-content");
    
    editor.setTheme("ace/theme/" + theme);
    editor.getSession().setMode("ace/mode/markdown");
    
    editor.on("change", function(event) {
        input.value = editor.getValue();
    });
    
    editor.container.addEventListener("paste", function(event) {
        var items = (event.clipboardData || event.originalEvent.clipboardData).items

        for (var i in items) {
            var item = items[i];

            if (item.type && item.type.match(/^image\/\w+$/)) {
                var file = item.getAsFile();
                if (file) {
                    var placeholder = "[正在上传图片....]()\n";

                    editor.insert(placeholder);

                    upload(file, function(xhr) {
                        var res = JSON.parse(xhr.response);
                        setTimeout(function() {
                            editor.replace(image(file.name, res.orig), {needle: placeholder});
                            editor.clearSelection();
                        }, 4000);
                    })
                }
            }
        }
    });
}
