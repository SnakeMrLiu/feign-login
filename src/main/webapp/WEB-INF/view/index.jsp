<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>layui布局</title>
    <link rel="stylesheet" href="../js/layui/css/layui.css"/>
    <script src="../js/layui/layui.js"></script>
    <%--<script src="../js/layui/layui.all.js"></script>--%>
    <script src="../js/jquery-1.8.0.js"></script>
</head>
<body>

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 大布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href=""><i class="layui-icon">&#xe60c;</i>控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="navBar layui-side-scroll"></div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="layui-tab" lay-filter="myTab" lay-allowclose="true">
                <ul class="layui-tab-title">
                    <li class="layui-this" lay-id="11">网站设置</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">内容1</div>
                </div>
            </div>
        </div>
    </div>

</div>


</body>
<%--<script src="treeJson.js"></script>--%>
<script>
    layui.use('layer', function(){
        var $ = layui.jquery, layer = layui.layer;
    layer.open({
        type: 1
        ,title: false //不显示标题栏
        ,closeBtn: false
        ,area: '300px;'
        ,shade: 0.8
        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
        ,btn: ['我知道了']
        ,btnAlign: 'c'
        ,moveType: 1 //拖拽模式，0或者1
        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">亲！欢迎光临流萤科技<br><br>流萤科技作为一个全球最大的军火商，由于其用户基数较大，所以常常会有人来购买导弹<br><br>流萤科技虽然是买军火的，但软件开发也是我们新的方向<br><br>我们此后的征途是星辰大海 ^_^</div>'
        ,success: function(layero){
            /*var btn = layero.find('.layui-layer-btn');
            btn.find('.layui-layer-btn0').attr({
                href: 'http://www.layui.com/'
                ,target: '_blank'
            });*/
        }
    });
    });
    var $;
    layui.use(['element'], function(){
        $ = layui.jquery
        var element = layui.element
        var myTab  = function(){
            this.tabConfig = {
                closed : true,
                openTabNum : 10,
                tabFilter : "myTab"
            }
        };
    var navs = "";
    $.ajax({
        url:"../tree/getTree",
        type:"post",
        dataType:"json",
        success:function(data){
            //显示左侧菜单
            if($(".navBar").html() == ''){
                var _this = this;
                $(".navBar").html(navBar(data)).height($(window).height()-230);
                element.init();  //初始化页面元素
                $(window).resize(function(){
                    $(".navBar").height($(window).height()-230);
                })
            }
            // 添加新窗口
            $(".layui-nav .layui-nav-item a").on("click",function(){

                //判断当前节点是否是子节点
                if($(this).children("span").length == 0){
                    //判断选项卡是否被打开过
                    if(!hasTab($(this).find("cite").text())){
                        element.tabAdd('myTab', {
                            title: '<cite>'+$(this).find("cite").text()+'</cite>'//用于演示
                            ,content:createFrame($(this).attr("data-url"))
                            ,id: $(this).attr("data-id")
                        })
                        element.tabChange('myTab', $(this).attr("data-id"));
                    }else{
                        element.tabChange('myTab', $(this).attr("data-id"));
                    }
                }
            })

        }

    })



    });
    function createFrame(url){
        return '<iframe scrolling="auto" frameborder="0"  src="'+ url + '" style="width:100%;height:100%;"></iframe>';
    }

    function hasTab(title){
        var tabIndex = false;
        $(".layui-tab-title li").each(function(){
            if($(this).find("cite").text() == title){
                tabIndex = true;
            }
        })
        return tabIndex;
    }


    function navBar(data){
        var ulHtml = '<ul class="layui-nav layui-nav-tree" lay-filter="myTree">';
        for(var i=0;i<data.length;i++){
            if(data[i].spread){
                ulHtml += '<li class="layui-nav-item layui-nav-itemed">';
            }else{
                ulHtml += '<li class="layui-nav-item">';
            }
            if(data[i].children != undefined && data[i].children.length > 0){
                ulHtml += '<a href="javascript:;" data-id="'+data[i].id+'">';
                if(data[i].icon != undefined && data[i].icon != ''){
                    if(data[i].icon.indexOf("icon-") != -1){
                        ulHtml += '<i class="iconfont '+data[i].icon+'" data-icon="'+data[i].icon+'"></i>';
                    }else{
                        ulHtml += '<i class="layui-icon" data-icon="'+data[i].icon+'">'+data[i].icon+'</i>';
                    }
                }
                ulHtml += '<cite>'+data[i].title+'</cite>';;
                ulHtml += '<span class="layui-nav-more"></span>';
                ulHtml += '</a>'
                ulHtml += '<dl class="layui-nav-child">';
                for(var j=0;j<data[i].children.length;j++){
                    ulHtml += '<dd><a href="javascript:;" data-id="'+data[i].children[j].id+'" data-url="'+data[i].children[j].href+'">';
                    if(data[i].children[j].icon != undefined && data[i].children[j].icon != ''){
                        if(data[i].children[j].icon.indexOf("icon-") != -1){
                            ulHtml += '<i class="iconfont '+data[i].children[j].icon+'" data-icon="'+data[i].children[j].icon+'"></i>';
                        }else{
                            ulHtml += '<i class="layui-icon" data-icon="'+data[i].children[j].icon+'">'+data[i].children[j].icon+'</i>';
                        }
                    }
                    ulHtml += '<cite>'+data[i].children[j].title+'</cite></a></dd>';
                }
                ulHtml += "</dl>"
            }else{
                ulHtml += '<a href="javascript:;" data-id="'+data[i].id+'" data-url="'+data[i].href+'">';
                if(data[i].icon != undefined && data[i].icon != ''){
                    if(data[i].icon.indexOf("icon-") != -1){
                        ulHtml += '<i class="iconfont '+data[i].icon+'" data-icon="'+data[i].icon+'"></i>';
                    }else{
                        ulHtml += '<i class="layui-icon" data-icon="'+data[i].icon+'">'+data[i].icon+'</i>';
                    }
                }
                ulHtml += '<cite>'+data[i].title+'</cite></a>';
            }
            ulHtml += '</li>'
        }
        ulHtml += '</ul>';
        return ulHtml;
    }


</script>
</html>
