/**
 * Created by yeliu on 15/8/27.
 */

var geturl = "MobileAPI.asmx/GetKQGongdan";
var UID = Date.now();
var para = {
    keyword: "dhccpass",
    pageSize:10,
    pageIndex:0,
    //key:"04525b79-1a50-4374-843d-5df0fc7ac095",
    //user_name: "chengcai",
    price1:0,
    price2:0,
    wdays:100,
    pricelist:0,
    wdayslist:0,
    hotlist:0
};

var geturl2 = "MobileAPI.asmx/GetProjectDetails";
var para2 = {
    keyword: "dhccpass",
    //workType:46,
    //workid:"2759d8d1-5fc8-4f63-a6f5-83ac9d711b04"
    ispublic:1
};

var setconfirm = function(){
    if($("#floatdia").length<1){
        return;
    }
    var hh = $(window).height();
    var ww = $(window).width();
    $("#floatdia").show();
    var h = $("#floatdia").height();
    var w = $("#floatdia").width();

    $("#floatdia").css("top",((hh-h)/2)+"px");
    $("#floatdia").css("left",((ww-w)/2)+"px");
};
var diahide= function(){
    $("#floatdia").hide();
}


var head = '<div class="block nobgcolor" style="padding-top:0.5em;"><table cellpadding="3" cellspacing="0" width="100%" style="font-size:medium;"><col width="25%" span="4"><tr><td align="center">岗位应聘</td><td align="center">岗位培训</td><td align="center">岗位认证</td><td align="center">承接工单</td></tr><tr><td style="background:url(../img/bb1.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb2.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb3.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb4.svg) no-repeat center center;">&nbsp;</td></tr></table></div>';


if($.urlGet()["key"]!=null){
    var key = $.urlGet()["key"];
    var name = $.urlGet()["name"];
    //var email = $.urlGet()["email"];
    //var phoneNum = $.urlGet()["phoneNum"];
    //var typeNum = $.urlGet()["typeNum"];
}


var setpage1 = function(){
    $("#page2").hide();
    $("#page1").show();
    window.location.href = 'info://' + "page" + "?" + "page1";
};
var setpage2 = function(){
    $("#page1").hide();
    $("#page2").show();
    window.location.href = 'info://' + "page" + "?" + "page2";
};
var allinfo = {};
var cc = null;

var gointo = function(sign, typeid){
    para2["workid"] = sign;
    para2["workType"] = typeid;

    $.post(geturl2, para2, function(data){

        var html = "";
        $(data).find("details").each(function(){

            var worktitle = $(this).find("worktitle").text();
            var yusuan = $(this).find("balances").text();
            var typename = $(this).find("typename").text();
            var projectname = $(this).find("projectname").text();
            var workdays = $(this).find("workdays").text();
            var addtime = $(this).find("addtime").text();
            var remark = $(this).find("remark").text();

            html += '<div class="block radius1">';
            html += '<div class="title2 underline1">'+worktitle+'<span class="price">'+yusuan+'</span></div>';
            html += '<p><span class="inner_title">工单类型：</span>'+typename+'</p>';
            html += '<p><span class="inner_title">所属项目：</span>'+projectname+'</p>';
            html += '<p><span class="inner_title">开发周期：</span>'+workdays+'</p>';
            html += '<p class="last span"><span class="inner_title">发布时间：</span>'+addtime+'</p>';
            html += '<p><span class="inner_title">工单描述：</span>';
            html += '<span class="desc">'+remark+'</span></p></div>';


            html += '<div class="block radius1"><p class="rela underline1"><span class="inner_title">抢单会员列表：</span>';

            var ss = Math.abs(parseInt($(this).find("seconds").text()));
            if(ss>1){
                var time = getdays(ss);
                //alert(projectname);
                var id1 = (UID++).toString(36);
                var seed = window.setInterval(function(){
                    ss = --ss > 0 ? ss:0;
                    if($("#"+id1).length>0){
                        var ddd = getdays(ss);
                        $("#"+id1).html(ddd);
                    }else{
                        window.clearInterval(seed);
                    }
                },1000);
                html += '<span class="showtime">剩余：<span id="'+id1+'"></span></span>';
            }else{
                html += '<span class="showtime">现无人抢单</span>';
            }

            html += '</p><!--<div class="list1"><div class="left">昵称<div class="right">6/31 15:30:28</div></div><div class="left">昵称<div class="right">6/31 15:30:28</div></div><div class="left">昵称<div class="right">6/31 15:30:28</div></div></div>--></div>';
            html += '<div class="block nobgcolor" ><div class="next radius1 link1" style="background-color:#0177d9;"><a href="#" onClick="setconfirm()">我要抢单</a></div></div>';
            html += '<div class="radius1" style="width:70%; position:absolute; padding-bottom:0.5em;text-align:center; color:#fff; background:rgba(0,0,0,0.5);display:none;" id="floatdia"><p style="border-bottom:#ccc 1px solid; padding-bottom:0.5em;">';
            html += "请去网站接单";
            html += '</p><div class="radius1" style="width:5em; background-color:#ffffff; margin:auto;line-height:2em; color:#000;"  onClick="diahide()">确定</div></div>';

            $("#page2").html(html);
            setpage2();

        });

    });

};

$(function(){
    para["key"] = key;
    para["user_name"] = name;
    var nodata = false;

    $.post(geturl, para, function(data){
        var html = "";
        $(data).find("details").each(function(){

            if($(this).find("info").text().indexOf("无数据")!=-1){
                nodata = true;
                return;
            }

            var worktitle = $(this).find("worktitle").text();
            //alert(title);
            var price = $(this).find("balances").text();
            //alert(price);
            var typename = $(this).find("typename").text();
            //alert(typename);

            var typeid = parseInt($(this).find("typeid").text());

            var projectname = $(this).find("projectname").text();
            //alert(projectname);
            var workdays =  $(this).find("workdays").text();
            //alert(days);

            var id =  $(this).find("id").text();




            html += '<div class="block radius1" onClick = "gointo(\''+id+'\', \''+typeid+'\')">';
            html += '<div class="title3 underline1">'+worktitle+'<span class="price">'+price+'</span></div>';
            html += '<p><span class="inner_title">工单类型：</span>'+typename+'</p>';
            html += '<p><span class="inner_title">所属项目：</span>'+projectname+'<span class="showtime"></span></p>';
            html += '<p class="rela"><span class="inner_title">开发周期：</span>'+workdays;

            var ss = Math.abs(parseInt($(this).find("seconds").text()));
            if(ss>1){
                var time = getdays(ss);
                //alert(projectname);
                var id1 = (UID++).toString(36);
                var seed = window.setInterval(function(){
                    ss = --ss > 0 ? ss:0;
                    if($("#"+id1).length>0){
                        var ddd = getdays(ss);
                        $("#"+id1).html(ddd);
                    }else{
                        window.clearInterval(seed);
                    }
                },1000);
                html += '<span class="showtime">剩余：<span id="'+id1+'"></span></span>';
            }else{
                html += '<span class="showtime">现无人抢单</span>';
            }


            html += '</p></div>';

        });
        if(nodata){
            html = '<div class="block radius1">';
            html += '<p>目前没有适合您的工单，在岗位认证后就可以承接相应的工单了</p>';
            html += '</div>';
        }
        $("#page1").html(html);
        setpage1();
    });


});
