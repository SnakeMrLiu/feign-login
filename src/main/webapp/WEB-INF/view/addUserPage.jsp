<%--
&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: snake
  Date: 2018/3/1
  Time: 18:33
  To change this template use File | Settings | File Templates.
&ndash;%&gt;
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../js/layui/css/layui.css"/>
    <script src="../js/layui/layui.js"></script>
    <script src="../js/jquery-1.8.0.js"></script>
</head>
<body>
<form class="layui-form" id="wwww">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名:</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="title" autocomplete="off" placeholder="请输入姓名" class="layui-input">
        </div>
    </div>
        <div class="layui-form-item">
        <label class="layui-form-label">性别:</label>
        <div class="layui-input-block">
            <input type="radio" name="sex" value="男" title="男">
            <input type="radio" name="sex" value="女" title="女">
        </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">爱好:</label>
            <div class="layui-input-block">
                <input type="checkbox" name="hobby" title="写作">
                <input type="checkbox" name="hobby" title="阅读">
                <input type="checkbox" name="hobby" title="游戏">
            </div>
        </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">地址:</label>
            <div class="layui-input-inline">
                <select name="address">
                    <option value="">请选择问题</option>
                    <optgroup label="城市记忆">
                        <option value="北京">北京</option>
                    </optgroup>
                    <optgroup label="学生时代">
                        <option value="上海">上海/option>
                        <option value="张家口">张家口</option>
                    </optgroup>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">出生日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="date" name="birthday" placeholder="yyyy-MM-dd">
            </div>
        </div>
    </div>
    <div class="layui-upload">
        <button type="button" class="layui-btn" id="photoid">上传照片</button>
        <div class="layui-upload-list" id="demo2">
            <input type="hidden" name="photo" id="photoName">
            <img class="layui-upload-img" id="photoDiv" >
            <p id="demoText"></p>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">详情:</label>
        <div class="layui-inline">
            <textarea id="edit" name="context"></textarea>
        </div>
    </div>
</form>

<script>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;  //特别注意  这里的两个参数必须要  不然的话  js会报错  一开始没注意 找了好久
        upload.render({
            elem: '#photoid'
            , accept:"file"
            , url: '../user/uploadFiles.do'
            , //multiple: true
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo2').append('<img src="' + result + '" width="50px" height="50px" class="layui-upload-img">')
                    $("#photoName").val(result);
                });
            }
            , Alldone: function (res) {     //done是单个上传完就执行回调  Alldone是全部上传完了才执行回调  后面才发现  入了一个很大的坑
                if (res) {
                    window.parent.location.reload();//刷新父级页面
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.layer.close(index); //再执行关闭

                }
            }
        });
    });
    layui.use(['form', 'layedit', 'laydate','layedit',"upload"], function(){
        var $ = layui.jquery
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
        //日期
        laydate.render({
            elem: '#date'
        });
        //创建一个编辑器
        var editIndex = layedit.build('edit',{
            height: 250,
        });
        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });


    });
</script>
</form>
</body>
</html>
--%>
