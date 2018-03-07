<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../js/layui/css/layui.css"/>
    <script src="../js/layui/layui.js"></script>
    <script src="../js/jquery-1.8.0.js"></script>
</head>
<body>
    <div id="pTable" style="width: 1200px;height:400px">
        <div class="layui-row">
            <div class="layui-col-xs12">
                <button class="layui-btn" onclick="addUser()" data-type="auto">新增用户</button>
                <button class="layui-btn layui-btn-danger" onclick="deleteMoreUser()" data-type="auto">批量删除</button>
            </div>
        </div>
        <table class="layui-table" id="layui_table_id" lay-filter="test">
        </table>
        <div id="laypage"></div>
    </div>
    <div id='info' style = "display : none">
        <form class="layui-form" id="userForm">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名:</label>
                <div class="layui-input-block">
                    <input type="text" name="name" lay-verify="title" id="userName" autocomplete="off" placeholder="请输入姓名" class="layui-input">
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
                    <input type="checkbox" name="hobby" title="写作" value="写作">
                    <input type="checkbox" name="hobby" title="阅读" value="阅读">
                    <input type="checkbox" name="hobby" title="游戏" value="游戏">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">地址:</label>
                    <div class="layui-input-inline">
                        <select name="address">
                            <option value="">请选择地区</option>
                                <option value="北京">北京</option>
                                <option value="上海">上海</option>
                                <option value="张家口">张家口</option>
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
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">封面</label>
                <input type="hidden" name="photo" id="image">
                <input type="hidden" name="id" id="id">
                <button type="button" class="layui-btn" id="test2">
                    <i class="layui-icon">&#xe67c;</i>上传图片
                </button>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">详情:</label>
                <div class="layui-inline">
                    <textarea id="edit" name="context"></textarea>
                </div>
            </div>
        </form>
    </div>
</body>
    <script>
        var limitcount = 10;
        var curnum = 1;
        //列表查询方法
        function productsearch(start,limitsize) {
            layui.use(['table', 'laypage','form', 'laydate'], function () {
                table = layui.table,
                    layform=layui.form
                    laydate = layui.laydate,
                    laypage = layui.laypage;
                table.render({
                    elem: '#layui_table_id'
                    , url: '../user/queryUser?page=' + start + '&limit=' + limitsize
                    , cols: [[
                        {checkbox: true, fixed: true}
                        , {field: 'id', title: 'ID', width: '110'}
                        , {field: 'name', title: '名称', width: '110'}
                        , {field: 'sex', title: '性别', width: '100'}
                        , {field: 'hobby', title: '爱好', width: '130',}
                        , {field: 'photo', title: '相片', width: '160'}
                        , {field: 'address', title: '籍贯', width: '130'}
                        , {field: 'birthday', title: '生日', width: '140'}
                        , {field: 'context', title: '详情', width: '120'}
                        , {fixed: 'right', width: '130', align: 'center', toolbar: '#barDemo'}
                    ]]
                    , page: false
                    , height: 410
                    , done: function (res, curr, count) {
                        laypage.render({
                            elem: 'laypage'
                            , count: count
                            , curr: curnum
                            , limit: limitcount
                            , limits:[10, 30, 50,100]
                            , layout: ['prev', 'page', 'next', 'skip', 'count', 'limit']
                            , jump: function (obj, first) {
                                if (!first) {
                                    curnum = obj.curr;
                                    limitcount = obj.limit;
                                    productsearch(curnum, limitcount);
                                }
                            }
                        })
                    }
                })
                table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                    $ = layui.jquery
                    var data = obj.data //获得当前行数据
                        , layEvent = obj.event; //获得 lay-event 对应的值
                    if (layEvent === 'detail') {
                        viewLableInfo(data.attrId);
                        layer.msg(data.attrId);
                    } else if (layEvent === 'del') {
                        layer.confirm("确认要删除吗，删除后不能恢复", {title: "删除确认"}, function (index) {
                            layer.close(index);
                            $.post("../user/deleteOne?id=" + data.id, function (data) {
                                layer.msg("删除成功!");
                                location.reload();
                            });
                        });
                        /* window.location.href="../book/deleteBook?id="+data.id;*/
                    } else if (layEvent === 'edit') {
                        layui.use('form', function(){
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            $("#userName").val(data.name);
                            $("#id").val(data.id);
                            //下拉框
                            $("[name='address']").val(data.address);
                            $("[name='birthday']").val(data.birthday);
                            $("[name='context']").val(data.context);
                            //单选
                            $("input[name='sex'][value=" +data.sex+ "]").attr("checked", true);
                            //复选框
                            var arr = new Array([]);
                            arr  = data.hobby.split(",");
                            $.each(arr,function(i,item){
                                $("input[name='hobby'][value="+item+"]").attr("checked","checked");
                            });
                            form.render();
                        });
                        layui.use('layer', function() { //独立版的layer无需执行这一句
                            var $ = layui.jquery,
                                layer = layui.layer; //独立版的layer无需执行这一句
                            layer.open({
                                type: 1,
                                offset: 't',
                                title:"修改用户",
                                content: $("#info"), //数组第二项即吸附元素选择器或者DOM
                                btn: ['确认',"取消"],
                                shade: 0,
                                area: ['750px', '500px'],
                                btnAlign: 'c',
                                yes: function(){
                                    layedit.sync(editIndex);
                                    $.ajax({
                                        url:"../user/addUser",
                                        async:false,
                                        data:$("#userForm").serialize(),
                                        type:"post",
                                        dataType:"json",
                                        async:true,
                                        success:function (data){
                                            layer.msg('这很优秀<br>修改成功了呢', {
                                                time: 5000, //5s后自动关闭
                                                btn: ['稳健']
                                            });
                                            layer.close();
                                            location.reload()
                                        }
                                    });
                                },
                                end: function () {
                                    $("input[type=reset]").trigger("click");
                                    location.reload()
                                },
                            });
                            layedit = layui.layedit
                            editIndex = layedit.build('edit',{
                                height: 250,
                            });
                        });
                    }
                });
            })
        }
        productsearch( curnum, limitcount);

function addUser(){
    layui.use('layer', function() { //独立版的layer无需执行这一句
        var $ = layui.jquery,
        layer = layui.layer; //独立版的layer无需执行这一句
        layer.open({
            type: 1,
            offset: 't',
            content: $("#info"), //数组第二项即吸附元素选择器或者DOM
            btn: ['确认',"取消"],
            shade: 0,
            area: ['750px', '500px'],
            btnAlign: 'c',
            yes: function(){
                layedit.sync(editIndex);
                $.ajax({
                    url:"../user/addUser",
                    async:false,
                    data:$("#userForm").serialize(),
                    type:"post",
                    dataType:"json",
                    async:true,
                    success:function (data){
                        layer.msg('这很优秀<br>新增成功！！', {
                            time: 5000, //5s后自动关闭
                            btn: ['稳健']
                        });
                        layer.close();
                        location.reload()
                    }
                 });
            },
            end:function (){
                location.reload()
            }
        });
        layedit = layui.layedit
        editIndex = layedit.build('edit',{
            height: 250,
        });
    });
}
        layui.use('upload', function(){
            var upload = layui.upload;
            //执行实例
            var uploadInst = upload.render({
                elem: '#test2' //绑定元素
                ,url: '../user/uploadFiles' //上传接口
                ,done: function(res){
                    //上传完毕回调
                    $ = layui.jquery;
                    $("#image").val(res.path);
                    layer.msg('"'+($("#image").val())+'"', {
                        time: 5000, //5s后自动关闭
                        btn: ['稳健']
                    });
                }
                ,error: function(res){

                }
            });
        });
        layui.use(['form', 'layedit', 'laydate'], function(){
            var $ = layui.jquery
            var form = layui.form
                ,layer = layui.layer
                ,laydate = layui.laydate
            //日期
            laydate.render({
                elem: '#date'
                ,type: 'datetime'
            });
        });

        function deleteMoreUser(){
            var ids = "";
            var checkStatus = table.checkStatus('layui_table_id')
                ,data = checkStatus.data;
            for (var i in data){
                ids += "," + data[i].id;
            }
            if(ids == ""){
                layer.msg("请选择需要删除的信息");
            }else{
                layer.confirm("确认删除勾选的用户？", {icon: 3, title:"确认"}, function(){
                    ids = ids.substr(1);
                    $.ajax({
                        url:"../user/deleteMoreUser",
                        type:"post",
                        data:{"ids":ids},
                        dataType:"json",
                        success:function(data){
                            if(data.success){
                                layer.msg("删除成功!");;
                                location.reload()
                            }
                        }
                    })
                }, function(){

                });
            }
        }
    </script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</script>
</html>
