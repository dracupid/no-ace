<h1> 使用说明 </h1>
<ol>
	<li>
		编辑远端文件: <%= host %>/?read=文件路径, 支持保存
	</li>
	<br/>
	<li>
		打开在线编辑器: <a href="/editor"> <%= host %>/editor </a>
	</li>
	<br/>
	<li>
		使用nobone静态资源服务浏览文件 <a href="/pre"> <%= host %>/pre </a>, 点击文件可进入编辑器
	</li>
	Notice: 静态资源根目录为：<%= rootDir %>
</ol>