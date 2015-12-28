/**
 * Created by yeliu on 15/8/27.
 */

if($.urlGet()["key"]!=null){
    var key = $.urlGet()["key"];
}
if($.urlGet()["name"]!=null){
    var name = $.urlGet()["name"];
}
var allget = 0;
var geturl1 = "MobileAPI.asmx/GetJob";
var para1 = {
    keyword: "dhccpass",
    type:1
};
var url1html = "";
var geturl2 = "MobileAPI.asmx/GetJob";
var para2 = {
    keyword: "dhccpass",
    type:2
};
var url2html = "";
var geturl3 = "MobileAPI.asmx/GetJob";
var para3 = {
    keyword: "dhccpass",
    type:3
};
var url3html = "";
var geturl4 = "MobileAPI.asmx/GetJob";
var para4 = {
    keyword: "dhccpass",
    type:4
};
var url4html = "";

var geturl5 = "MobileAPI.asmx/GetJobDetails";
var para5 = {
    keyword: "dhccpass",
    resumestate:""

    //resumeid: "f20bec54-b9d8-403e-88b7-76aec282f1d3",
    //user_name:"transient"
};

var geturl6 = "MobileAPI.asmx/ChangeJobState";
var para6 = {
    keyword: "dhccpass",
    user_name: name
    //resumeid: "f20bec54-b9d8-403e-88b7-76aec282f1d3",
    //user_name:"transient"
};

var states= {
    //"未应聘":"",
    /*"已应聘"*/2:'<img src="img/yp.svg">',
    /*"审核中"*/3:'<img src="img/sh.svg">',
    /*"未付费"*/4:'<img src="img/ff.svg">',
    /*"已认证"*/5:'<img src="img/rz.svg">'
};
var words = {
    /*"未应聘"*/1:'我要应聘',
    /*"已应聘"*/2:'参加考试',
    /*"审核中"*/3:'等待审核',
    /*"未付费"*/4:'去领取勋章',
    /*"已认证"*/5:'我要接单'
};
var msg = {
    /*"未应聘"*/1:'应聘成功<br>请到官方网站上参加培训',
    /*"已应聘"*/2:'请到官方网站上参加考试',
    /*"审核中"*/3:'',
    /*"未付费"*/4:'请到官方网站上领取勋章',
    /*"已认证"*/5:'去网站接单'
};
var getdialog = function(sign, jobid){
    var html = "";
    if(sign == 3){
        return html;
    }

    html += '<div class="radius1" style="width:70%; position:absolute; padding-bottom:0.5em;text-align:center; color:#fff; background:rgba(0,0,0,0.5);display:none;" id="floatdia"><p style="border-bottom:#ccc 1px solid; padding-bottom:0.5em;">';
    html += msg[sign];
    html += '</p><div class="radius1" style="width:5em; background-color:#ffffff; margin:auto;line-height:2em; color:#000;"  onClick="';
    if(sign == 1){
        html += 'setyinping(\''+jobid+'\')';
    }
    html += ';diahide()">确定</div></div>';

    return html;
};

var head = '<div class="block nobgcolor" style="padding-top:0.5em;"><table cellpadding="3" cellspacing="0" width="100%" style="font-size:medium;"><col width="25%" span="4"><tr><td align="center">岗位应聘</td><td align="center">岗位培训</td><td align="center">岗位认证</td><td align="center">承接工单</td></tr><tr><td style="background:url(../img/bb1.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb2.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb3.svg) no-repeat center center;">&nbsp;</td><td style="background:url(../img/bb4.svg) no-repeat center center;">&nbsp;</td></tr></table></div>'+'<div class="collap">';

//page2
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
var setyinping = function(jobid){
    para6["jobid"] = jobid;
    $.post(geturl6, para6, function(data){

        window.location.href = 'info://' + "page" + "?" + "page99";
        //gointo(jobid);
    });
};

var diahide= function(){
    $("#floatdia").hide();
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

var startsetcollap = function(){
    if(allget > 3){
        $("#page1").html(head+url1html + url2html + url3html + url4html + "</div>");
        setcollap();
        setpage1();
    }
};


var gointo = function(sign, sign1){

    para5["resumeid"] = sign;
    para5["user_name"] = decodeURIComponent(name);
    if(sign1 == null){
        para5["resumestate"] = "";
    }else{
        para5["resumestate"] = sign1;
    }


    $.post(geturl5, para5, function(data){
        console.log(para5);
        var html = "<div class=\"collap2\">";
        var state = "", img = "";
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var jobid = $(this).find("id").text();
            state = $(this).find("state").text();

            if(states[state] != null){
                img ='<div class="iconadd">'+states[state]+'</div>';
            }
            var desc = $(this).find("intro").text();

            html += '<div class="block radius1">';
            html += '<div class="collaptitle underline1"><a href="#">'+title+'</a>'+img+'</div>';
            html += '<div class="collapcontent"><div class="collapcontentdesc">'+desc+'</div></div></div>'

            var desc = $(this).find("requirement").text();

            html += '<div class="block radius1">';
            html += '<div class="collaptitle underline1"><a href="#">应聘条件</a></div>';
            html += '<div class="collapcontent"><div class="collapcontentdesc">'+desc+'</div></div></div>'

            desc = $(this).find("description").text();

            html += '<div class="block radius1">';
            html += '<div class="collaptitle underline1"><a href="#">岗位职责</a></div>';
            html += '<div class="collapcontent"><div class="collapcontentdesc">'+desc+'</div></div></div>'

            desc = $(this).find("treatment").text();

            html += '<div class="block radius1">';
            html += '<div class="collaptitle underline1"><a href="#">岗位酬劳</a></div>';
            html += '<div class="collapcontent"><div class="collapcontentdesc">'+desc+'</div></div></div>'

        });
        html += "</div>";
        html +='<div class="block nobgcolor" ><div class="next radius1 link1 bcolor2"><a href="#" onClick="setconfirm()">'+words[state]+'</a></div></div>';

        html += getdialog(state, sign);

        $("#page2").html(html);
        setcollap2();
        setpage2();

    });

};




$(function(){
    para1["user_name"] = decodeURIComponent(name);
    $.post(geturl1, para1,function(data){

        var html = "";
        html += '<div class="block radius1">';
        html += '<div class="collaptitle underline1"><a href="#">软件工厂岗位</a></div><div class="collapcontent">';
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var state = $(this).find("state").text();
            var id = $(this).find("id").text();

            var img = "";
            if(states[state] != null){
                img ='<div class="iconadd">'+states[state]+'</div>';
            }
            html += '<div class="'+getnamecss(title)+' underline1"><a href="#" onclick="gointo(\''+id+'\','+state+')">'+title+'</a>'+img+'</div>';
        });
        html += '</div></div>';
        url1html = html;
        allget++;
        startsetcollap();
    });

});
$(function(){
    para2["user_name"] = name;
    $.post(geturl2, para2, function(data){

        var html = "";
        html += '<div class="block radius1">';
        html += '<div class="collaptitle underline1"><a href="#">商务中心岗位</a></div><div class="collapcontent">';
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var state = $(this).find("state").text();
            var id = $(this).find("id").text();

            var img = "";
            if(states[state] != null){
                img ='<div class="iconadd">'+states[state]+'</div>';
            }
            html += '<div class="'+getnamecss(title)+' underline1"><a href="#" onclick="gointo(\''+id+'\','+state+')">'+title+'</a>'+img+'</div>';
        });
        html += '</div></div>';
        url2html = html;

        allget++;
        startsetcollap();
    });

});
$(function(){
    para3["user_name"] = decodeURIComponent(name);

    $.post(geturl3, para3,function(data){

        var html = "";
        html += '<div class="block radius1">';
        html += '<div class="collaptitle underline1"><a href="#">软件研究院岗位</a></div><div class="collapcontent">';
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var state = $(this).find("state").text();
            var id = $(this).find("id").text();

            var img = "";
            if(states[state] != null){
                img ='<div class="iconadd">'+states[state]+'</div>';
            }
            html += '<div class="'+getnamecss(title)+' underline1"><a href="#" onclick="gointo(\''+id+'\','+state+')">'+title+'</a>'+img+'</div>';
        });
        html += '</div></div>';
        url3html = html;

        allget++;
        startsetcollap();
    });

});
$(function(){
    para4["user_name"] = decodeURIComponent(name);

    $.post(geturl4, para4, function(data){
        var html = "";
        html += '<div class="block radius1">';
        html += '<div class="collaptitle underline1"><a href="#">高级顾问岗位</a></div><div class="collapcontent">';
        $(data).find("details").each(function(){
            var title = $(this).find("title").text();
            var state = $(this).find("state").text();
            var id = $(this).find("id").text();

            var img = "";
            if(states[state] != null){
                img ='<div class="iconadd">'+states[state]+'</div>';
            }
            html += '<div class="'+getnamecss(title)+' underline1"><a href="#" onclick="gointo(\''+id+'\','+state+')">'+title+'</a>'+img+'</div>';
        });
        html += '</div></div>';
        url4html = html;

        allget++;
        startsetcollap();
    });

});
