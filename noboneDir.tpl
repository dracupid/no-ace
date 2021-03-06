<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1">

    <title>List Directory - <%= path %></title>

    <style type="text/css">
        <%= css %>
    </style>
</head>
<body>

    <%
    var formatTime = function (t) {
        if (typeof t == 'string')
            return t;

        return t.toDateString() + ' ' + t.toLocaleTimeString();
    }

    var formatSize = function (s) {
        if (typeof s == 'string')
            return s;

        if (s >= 1024 * 1024 * 1024)
            s = (s / 1024 / 1024 / 1024).toFixed(1) + 'G'
        else if (s >= 1024 * 1024)
            s = (s / 1024 / 1024).toFixed(1) + 'M'
        else if (s >= 1024)
            s = (s / 1024).toFixed(1) + 'K'
        else
            s = s + 'B'

        return s;
    }

    var renderList = function (list, opts) {
        opts = opts || {};
        postFix = opts.isDir ? '/' : '';
        _.each(list, function (el) {
    %>

        <div class='item'>
            <% if (opts.isSource && ! /\.jpg|\.png|\.gif|\.exe|\.psd|\.mp3|\.aac|\.zip|\.rar$/.test(el.path)) { %>
                <a class='source' title='view source code' href="/?read=__PWD__<%= encodeURIComponent(path + el.path ) %>" target="_blank">
                    &lt;&gt;&nbsp;
                </a>
            <% } %>

            <a class="name" href="<%= encodeURIComponent(el.path) + postFix %>">
                <%= el.path + postFix %>
            </a>
            <div class="dirCount">
                <%= el.dirCount == undefined ? '' : el.dirCount %>
            </div>
            <div class="size">
                <%= el.size && formatSize(el.size) %>
            </div>
            <div class="mtime">
                <%= el.mtime && formatTime(el.mtime) %>
            </div>
        </div>

    <%
        });
    }
    %>

    <h1 class="path">
        <%= path %>
    </h1>

    <div class="titles">
        <div class='item'>
            <span class="name">
                Name
            </span>
            <span class="dirCount">
                Count
            </span>
            <span class="size">
                Size
            </span>
            <span class="mtime">
                Modified
            </span>
        </div>
    </div>

    <div class="dirs">
        <% renderList(list.dirs, { isDir: true }) %>
    </div>

    <div class="files">
        <% renderList(list.files, { isSource: true }) %>
    </div>

</body>
</html>
