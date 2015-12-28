var pjname = "";
var pjtype1 = "";
var pjtype = "";
var pjdesc = "";
var contactname = "";
var validday = "";
var email = "";
var qq = "";
var weixin = "";
var needsign = "";
var isscene = "";
var key = "";

if ($.urlGet()["key"] != null) {
    key = $.urlGet()["key"];
}
var name = "";
if ($.urlGet()["name"] != null) {
    name = $.urlGet()["name"];
}

var setlogin = false;
var phone = "";
if ($.urlGet()["phoneNum"] != null && $.urlGet()["phoneNum"].match(/^\s*1\d{10}$/)) {
    phone = $.urlGet()["phoneNum"];
    setlogin = true;
}

var geturl = "job.xml";
var geturl1 = "http://218.61.196.194:9009/MobileAPI.ASMX/AddDemand";

var geturl2 = "MobileAPI.asmx/Send";
var para2 = {
    keyword: "dhccpass",
    //phone:"13916908666",
    userid: ""
};

var geturl3 = "MobileAPI.asmx/Validate";
var para3 = {
    keyword: "dhccpass",
    //phone:"13916908666",
    userid: ""
};

var geturl4 = "MobileAPI.asmx/AddDemand";
var para4 = {
    keyword: "dhccpass"
};

var UID = Date.now();
var lll = {};


var setlist = function (oo) {
    $("#llist").data("show", false).hide();
    var ll = lll[$(oo).html()];
    $("#selecttext1").html($(oo).html());
    var html = "";
    $.each(ll, function (i, d) {
        html += "<p class='underline1' onClick='setllist(this)' style='background-color:#fff; width:90%; padding-left:1em;'>" + d + "</p>";
    });
    $("#lllist").html(html);
    $("#selecttext2").html("");
};
var setllist = function (oo) {
    $("#lllist").data("show", false).hide();
    $("#selecttext2").html($(oo).html());
};
function showllist() {
    if (!$("#llist").data("show")) {
        $("#llist").show().data("show", true);
    } else {
        $("#llist").hide().data("show", false);
    }
}
function showlllist() {
    if (!$("#lllist").data("show")) {
        $("#lllist").show().data("show", true);
    } else {
        $("#lllist").hide().data("show", false);
    }
}

var setpage1 = function () {
    $("#page1").show();
    $("#page2").hide();
    $("#page3").hide();
    $("#page4").hide();
    window.location.href = 'info://' + "page" + "?" + "page1";

};
var setpage2 = function () {
    $("#page1").hide();
    $("#page2").show();
    $("#page3").hide();
    $("#page4").hide();
    window.location.href = 'info://' + "page" + "?" + "page2";

};
var setpage3 = function () {
    $("#page1").hide();
    $("#page2").hide();
    $("#page3").show();
    $("#page4").hide();
    window.location.href = 'info://' + "page" + "?" + "page3";

};
var showcontact = function () {
    $("#page1").hide();
    $("#page2").hide();
    $("#page3").hide();
    $("#page4").show();
    window.location.href = 'info://' + "page" + "?" + "page4";
};


var setnext1 = function () {
    $("#errorinfo").html("");
    if ($("#pjname").val().match(/^\s*$/)) {
        $("#errorinfo").html("* 项目名称不能为空！");
        return;
    }
    if ($("#pjname").val().length < 2) {
        $("#errorinfo").html("* 项目名称请输入2-30个字符！");
        return;
    }



    pjname = $("#pjname").val();

    if ($("#selecttext1").text() == "选择项目类型") {
        $("#errorinfo").html("* 请正确选择项目类型！");
        return;
    }
    pjtype1 = $("#selecttext1").text();
    if ($("#selecttext2").text() == "选择项目类型" || $("#selecttext2").text() == "") {
        $("#errorinfo").html("* 请正确选择项目类型！");
        return;
    }
    pjtype = $("#selecttext2").text();

    if ($("#pjdesc").val().match(/^\s*$/)) {
        $("#errorinfo").html("* 请输入项目描述内容！");
        return;
    }
    pjdesc = $("#pjdesc").val();

    validday = $("#datalimit").text();

    setpage2();
};

var setnext2 = function () {
    if (setlogin) {
        setnext2_1();
        return;
    }
    para3["code"] = $("#codeinput").val();
    //alert(para3["code"]);

    para3["phoneOrEmail"] = phone;
    //alert(para3["phoneOrEmail"]);
    $.post(geturl3, para3, function (data) {
        if ($(data).find("status").text() == "1") {
            setnext2_1();
        } else {
            $("#errorinfo2").html("* 验证码错误！");
            return;
        }
    });
};

var setnext2_1 = function () {
    $("#errorinfo2").html("");
    if ($("#contactname").val().match(/^\s*$/)) {
        $("#errorinfo2").html("* 请正确输入联系人！");
        return;
    }
    contactname = $("#contactname").val();


    if (!setlogin) {
        if (!$("#phone_no").val().match(/^\s*1\d{10}$/)) {
            $("#errorinfo2").html("* 请正确输入11位手机号！");
            return;
        }
        phone = $("#phone_no").val();
    }


    $("#pjname_").html(pjname);

    $("#pjtype_").html(pjtype);
    $("#pjdesc_").html(pjdesc.replace(new RegExp("\n", "gm"), 
    "<br>").replace(new RegExp(" ", "gm"), "&nbsp;"));

    $("#name_").html(contactname);
    $("#phone_").html(phone);
    $("#validday_").html(validday);
    $("#email_").html($("#email").val());
    $("#qq_").html($("#qq").val());
    $("#weixin_").html($("#weixin").val());

    if ($("#needsign").is(':checked')) {
        $("#needsign_").html("项目需要进行现场实施");
        isscene = 1;
    } else {
        $("#needsign_").html("项目不需要进行现场实施");
        isscene = 0;
    }


    setpage3();

};
var setconfirm = function () {
    if (!$("#readed").is(":checked")) {
        return;
    }
    if (setlogin) {
        para4["user_name"] = decodeURIComponent(name);
    } else {
        para4["user_name"] = "";
    }

    qq = $("#qq_").html();
    weixin = $("#weixin_").html();
    email = $("#email_").html();

    para4["demandtitle"] = pjname;
    para4["projectindustry"] = pjtype1;
    para4["categoryname"] = pjtype;
    para4["enddate"] = parseInt(validday);
    para4["details"] = pjdesc;
    para4["linkman"] = contactname;
    para4["telphone"] = phone;
    para4["code"] = "";
    para4["email"] = email;
    para4["QQ"] = qq;
    para4["weixin"] = weixin;
    para4["isscene"] = isscene;
    
    console.log(geturl4);
    console.log(para4);

    $.post(geturl4, para4, function (data) {
        //alert( $(data).text() );
        console.log(data);
        if ($(data).find("status").text() == "1") {
            $("#errorinfo3").hide();
            showconfirm();
        } else {
            $("#errorinfo3").show().html($(data).find("msg").text());
        }
    });
};

var showconfirm = function () {
    var hh = $(window).height();
    var ww = $(window).width();
    $("#floatdia").show();
    var h = $("#floatdia").height();
    var w = $("#floatdia").width();

    $("#floatdia").css("top", ((hh - h) / 2) + "px");
    $("#floatdia").css("left", ((ww - w) / 2) + "px");
};

var diahide = function () {
    $("#floatdia").hide();
    //跳转
    window.location.href = 'info://' + "page" + "?" + "page99";
}


$(function () {
    $.get(geturl, function (data) {
        var html = "";
        $(data).find("details").each(function () {
            var title = $(this).find("title").text();
            lll[title] = [];
            $(this).find("item").each(function () {
                lll[title].push($(this).text());
            });

        });

        $.each(lll, function (o) {
            $("#llist").append("<p class='underline1' onClick='setlist(this)'" 
            + " style='background-color:#fff; width:90%; padding-left:1em;'>" + o + "</p>");

        });

    });


    if (setlogin) {
        $("#setcheck").hide();
        $("#phoneno").html(phone);
    }

    var send = false;

    $("#getcode").click(function () {
        if (!send) {
            if ($("#phone_no").length > 0) {
                if (!$("#phone_no").val().match(/^\s*1\d{10}$/)) {
                    $("#errorinfo2").html("* 请正确输入11位手机号！");
                    return;
                }
                phone = $("#phone_no").val();
            }
            para2["phone"] = phone;

            $.post(geturl2, para2, function (data) {

            });


            var tt = 60;
            var seed = window.setInterval(function () {
                tt = tt - 1;
                if (tt < 1) {
                    send = false;
                    window.clearInterval(seed);
                    $("#getcode").html("获取验证码");
                } else {
                    $("#getcode").html(tt + "s 后重发");
                }
            }, 1000);
            send = true;
        }
    });
    setpage1();
});