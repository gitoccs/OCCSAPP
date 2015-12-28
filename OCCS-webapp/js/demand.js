/**
 * Created by yeliu on 15/8/27.
 */

var geturl = "MobileAPI.asmx/GetAllDemand";
var para = {keyword: "dhccpass",
    pageSize:10,
    pageIndex:0,
    status:-1,
    cid:"all"
};

var geturl2 = "MobileAPI.asmx/GetProjectDetails";
var para2 = {
    keyword: "dhccpass",
    workType:10,
    ispublic:1
};

var UID = Date.now();
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

var gointo = function(sign){
    para2['workid'] = sign;
    $.post(geturl2, para2, function(data){
        var html = "";
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var type = $(this).find("typename").text();
            var workdays = $(this).find("workdays").text();
            var yusuan = $(this).find("balances").text();
            var addtime = $(this).find("addtime").text();
            var remark = $(this).find("remark").text();


            html += '<div class="block radius1">';
            html += '<div class="title2 underline1">'+title+'</div>';
            html += '<p><span class="inner_title">项目类型：</span>'+type+'</p>';
            html += '<p><span class="inner_title">项目工期：</span>'+workdays+'</p>';
            html += '<p><span class="inner_title">项目预算：</span>'+yusuan+'</p>';
            html += '<p><span class="inner_title">发布日期：</span>'+addtime+'</p>';
            html += '<p><span class="inner_title"  style="color:#F60;">项目需求：</span>';
            html += '<span class="desc">'+remark+'</span></p></div>';

            html += '<div class="block radius1"><p class="rela underline1"><span class="inner_title">竞标企业列表：</span>';


            var ss = Math.abs(parseInt($(this).find("seconds").text()));
            if(ss>1){
                var time = getdays(ss);
                //alert(projectname);
                var id1 = (UID++).toString(36);
                var seed =  window.setInterval(function(){
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

            html += '</p><!--<div class="list1"><div class="left">昵称<div class="right">6/31 15:30:28</div></div><div class="left">昵称<div class="right">6/31 15:30:28</div></div><div class="left">昵称<div class="right">6/31 15:30:28</div></div></div></div>-->';

        });

        $("#page2").html(html);
        setpage2();
    });
};


$(function(){
    $.post(geturl, para, function(data){
        var html = "";
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            //alert(title);
            var type = $(this).find("type").text();
            //alert(title);
            var yusuan = $(this).find("balances").text();
            //alert(yusuan);
            var workdate = $(this).find("workdate").text();

            var id =  $(this).find("id").text();


            html += '<div class="block radius1" onClick = "gointo(\''+id+'\')">';
            html += '<div class="title3 underline1">'+title+'</div>';
            html += '<p><span class="inner_title">项目类型：</span>'+type+'</p>';
            html += '<p><span class="inner_title">开发工期：</span>'+workdate+'</p>';
            html += '<p class="rela"><span class="inner_title">项目预算：</span>'+yusuan;


            var ss = Math.abs(parseInt($(this).find("seconds").text()));
            if(ss>1){
                var time = getdays(ss);
                //alert(projectname);
                var id1 = (UID++).toString(36);
                var seed =  window.setInterval(function(){
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

        $("#page1").html(html);
    });

    setpage1();
});
