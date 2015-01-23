<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Remote Editor</title>
  <style type="text/css" media="screen">
    body {
        overflow: hidden;
        font-family: 'Avenir Next', Avenir, Tahoma, Arial, 'Helvetica Neue', 'Lantinghei SC', "Hiragino Sans GB", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
    }

    #editor {
        margin: 0;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
    }
    #save{
      position: fixed;
      top: 30px;
      right: 20px;
      color: #000;
      overflow: visible;
      display: inline-block;
      padding: 0.5em 1em;
      border: 1px solid #d4d4d4;
      margin: 0;
      text-decoration: none;
      text-align: center;
      text-shadow: 1px 1px 0 #fff;
      white-space: nowrap;
      cursor: pointer;
      outline: none;
      background-color: #ececec;
      background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#f4f4f4), to(#ececec));
      background-image: -moz-linear-gradient(#f4f4f4, #ececec);
      background-image: linear-gradient(#f4f4f4, #ececec);
      -moz-background-clip: padding;
      background-clip: padding-box;
      border-radius: 0.2em;
      zoom: 1;
      font-size: 14px;
      z-index: 99999;
    }
    #save:hover, #save:focus, #save:active{
        border-color: #3072b3;
        border-bottom-color: #2a65a0;
        text-decoration: none;
        text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
        color: #fff;
        background-color: #3c8dde;
        background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#599bdc), to(#3072b3));
        background-image: -moz-linear-gradient(#599bdc, #3072b3);
        background-image: linear-gradient(#599bdc, #3072b3);
    }
  </style>
</head>
<body>

<pre id="editor" data-path="<%= path %>"><%= code %></pre>

<button id="save">SAVE</button>
<script src="http://music.baidu.com/cms/webview/common/js/zepto-1.1.6.min.js"></script>
<script src="src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode("ace/mode/<%= language %>");

    $('#save').on('click', function(){
        $.post('/save', {
            file: $('#editor').data('path'),
            data: editor.getValue()
        }).then(function(res){
            if(res === 'true'){
              alert("保存成功, 你可以刷新页面来确认效果");
            } else {
              alert("保存失败");
            }
        });
    });

</script>

</body>
</html>
