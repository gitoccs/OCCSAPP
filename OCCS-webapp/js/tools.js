// JavaScript Document

(function ($) {
    $.extend({
        urlGet: function () {
            var aQuery = window.location.href.split("?");
            var aGET = new Array();
            if (aQuery.length > 1) {
                var aBuf = aQuery[1].split("&");
                for (var i = 0, iLoop = aBuf.length; i < iLoop; i++) {
                    var aTmp = aBuf[i].split("=");
                    aGET[aTmp[0]] = aTmp[1];
                }
            }
            return aGET;
        }
    })
})(jQuery);

function getMobileOperatingSystem() {
  var userAgent = navigator.userAgent || navigator.vendor || window.opera;

  if( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) )
  {
    return 'iOS';
  }
  else if( userAgent.match( /Android/i ) )
  {

    return 'Android';
  }
  else
  {
    return 'unknown';
  }
}


function setcollap() {
    $(".collap .collaptitle").click(function () {
        if ($(this).data("exp")) {
            $(this).closest(".collap").find(".collapcontent").hide().end().find(".collaptitle").data("exp", false).removeClass("collaptitleexp").addClass("collaptitle");
            $(this).data("exp", false).next(".collapcontent").hide();
            $(this).addClass("collaptitle");
        } else {
            $(this).closest(".collap").find(".collapcontent").hide().end().find(".collaptitle").data("exp", false).removeClass("collaptitleexp").addClass("collaptitle");
            $(this).data("exp", true).addClass("collaptitleexp").next(".collapcontent").show();
        }
        $(this).blur();
    });
}

function setbuttom() {
    var dd = 5;
    $("#leftbb").click(function () {
        dd = (dd - 5) > 5 ? (dd - 5) : 5;
        $("#datalimit").html(dd + "天");
    });
    $("#rightbb").click(function () {
        dd = (dd + 5) < 30 ? (dd + 5) : 30;
        $("#datalimit").html(dd + "天");
    });
}
function setcollap2() {
    $(".collap2 .collaptitle").click(function () {
        if ($(this).data("exp")) {
            $(this).closest(".collap2").find(".collapcontent").hide().end().find(".collaptitle").data("exp", false).removeClass("collaptitleexp").addClass("collaptitle");
            $(this).data("exp", false).next(".collapcontent").hide();
            $(this).addClass("collaptitle");
        } else {
            $(this).closest(".collap2").find(".collapcontent").hide().end().find(".collaptitle").data("exp", false).removeClass("collaptitleexp").addClass("collaptitle");
            $(this).data("exp", true).addClass("collaptitleexp").next(".collapcontent").show();
        }
        $(this).blur();
    });
}

var typeidname = {
    10: "项目解决方案",
    11: "业务需求分析",
    15: "项目报价评估",
    20: "概要设计工单",
    22: "业务功能拓扑工单",
    25: "开发工单",
    30: "业务功能拓扑工单(30)",
    40: "页面展现拓扑工单",
    45: "业务流程拓扑工单",
    46: "组件制作工单",
    50: "组件配置拓扑工单",
    60: "单元测试工单",
    70: "集成测试工单",
    80: "项目实施工单",
    90: "运维工单",
    110: "软件云工厂分厂厂长",
    510: "软件项目营销专员",
    520: "会员发展专员",
    530: "市场推广专员",
    540: "在线客服专员",
    570: "网站市场策划",
    580: "网站营销策划"
};

var namell = {
    "软件工厂厂长": "icon01_01",
    "解决方案架构师": "icon01_02",
    "需求分析师": "icon01_03",
    "业务功能拓扑专员": "icon01_04",
    "页面展现拓扑专员": "icon01_05",
    "组件制作专员": "icon01_06",
    "组件配置拓扑专员": "icon01_07",
    "单元测试专员": "icon01_08",
    "集成测试专员": "icon01_09",
    "项目运维专员": "icon01_10",
    "ui设计师": "icon01_11",
    "项目实施专员": "icon01_12",
    "系统设计师": "icon01_13",
    "业务流程拓扑专员": "icon01_14",
    "会员发展专员": "icon02_01",
    "软件项目营销专员": "icon02_02",
    "网站市场策划": "icon02_03",
    "网站推广专员": "icon02_04",
    "网站营销策划": "icon02_05",
    "项目报价评估师": "icon02_06",
    "在线客服专员": "icon02_07",
    "全新技术研究": "icon03_01",
    "组件化研究": "icon03_02",
    "技术咨询顾问": "icon04_01",
    "市场分析顾问": "icon04_02",
    "业务咨询顾问": "icon04_03",
    "资深评论顾问": "icon04_04"
};

function gettypeidname(sign) {
    return typeidname[sign];
}
function getprice(str) {
    if (str.indexOf("合同金额的") != -1) {
        return str;
    } else {
        return "￥" + parseInt(str);
        ;
    }
}

function dateDiffToTime(oldDate, newDate) {
    // console.log("oldDate : " + oldDate);
    // console.log("newDate : " + newDate);
    var offset = new Date().getTimezoneOffset() * 60;
    var newdatetime = Date.parse(new Date(newDate)) / 1000 + offset;
    var olddatetime = Date.parse(new Date(oldDate)) / 1000;

    var timeStr;
    if (newdatetime > olddatetime)
        timeStr = "剩余：";
    else
        timeStr = "超过：";

    var delta = Math.abs(newdatetime - olddatetime);
    var days = Math.floor(delta / 86400);
    delta -= days * 86400;
    var hours = Math.floor(delta / 3600) % 24;
    delta -= hours * 3600;
    var minutes = Math.floor(delta / 60) % 60;
    delta -= minutes * 60;
    var seconds = delta % 60;
    return {
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        status:timeStr
    }
}

function dateLeftSeconds(leftSeconds){
    var preStr = "";
    if(seconds > 0){
        preStr = "超过：";
    }else{
        preStr = "剩下：";
    }
    
    var delta = Math.abs(leftSeconds);
    var days = Math.floor(delta / 86400);
    delta -= days * 86400;
    var hours = Math.floor(delta / 3600) % 24;
    delta -= hours * 3600;
    var minutes = Math.floor(delta / 60) % 60;
    delta -= minutes * 60;
    var seconds = delta % 60;
    return {
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        status:preStr
    }
}

Date.prototype.format = function(format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
}

function getdays(tt) {
    var d = parseInt(tt / 86400);
    var h = parseInt((tt - d * 86400) / 3600);
    var m = parseInt((tt - d * 86400 - h * 3600) / 60);
    var s = parseInt(tt - d * 86400 - h * 3600 - m * 60);
    return d + "天" + h + "时" + m + "分" + s + "秒";
}
function getnamecss(n) {
    if (namell[n] != null) {
        return namell[n];
    } else {
        return 'icon001';
    }

}

$.loadXML = function (url, data, method, callback) {
    $.ajax({
        type: method,
        url: url,
        dataType: "xml",
        data: data,
        success: function (xml) {
            callback(xml);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(XMLHttpRequest.status);
            console.log(XMLHttpRequest.readyState);
            console.log(textStatus);
        }
    });
};

$.fn.toObject = function (){
    if (this==null) return null;
    var retObj = new Object;
    buildObjectNode(retObj,/*jQuery*/this.get(0));
    return $(retObj);
    function buildObjectNode(cycleOBJ,/*Element*/elNode){
        /*NamedNodeMap*/
        var nodeAttr=elNode.attributes;
        if(nodeAttr != null){
            if (nodeAttr.length&&cycleOBJ==null) cycleOBJ=new Object;
            for(var i=0;i<nodeAttr.length;i++){
                cycleOBJ[nodeAttr[i].name]=nodeAttr[i].value;
            }
        }
        var nodeText="text";
        if (elNode.text==null) nodeText="textContent";
        /*NodeList*/
        var nodeChilds=elNode.childNodes;
        if(nodeChilds!=null){
            if (nodeChilds.length&&cycleOBJ==null) cycleOBJ=new Object;
            for(var i=0;i<nodeChilds.length;i++){
                if (nodeChilds[i].tagName!=null){
                    if (nodeChilds[i].childNodes[0]!=null&&nodeChilds[i].childNodes.length<=1&&(nodeChilds[i].childNodes[0].nodeType==3||nodeChilds[i].childNodes[0].nodeType==4)){
                        if (cycleOBJ[nodeChilds[i].tagName]==null){
                            cycleOBJ[nodeChilds[i].tagName]=nodeChilds[i][nodeText];
                        }else{
                            if (typeof(cycleOBJ[nodeChilds[i].tagName])=="object"&&cycleOBJ[nodeChilds[i].tagName].length){
                                cycleOBJ[nodeChilds[i].tagName][cycleOBJ[nodeChilds[i].tagName].length]=nodeChilds[i][nodeText];
                            }else{
                                cycleOBJ[nodeChilds[i].tagName]=[cycleOBJ[nodeChilds[i].tagName]];
                                cycleOBJ[nodeChilds[i].tagName][1]=nodeChilds[i][nodeText];
                            }
                        }
                    }else{
                        if (nodeChilds[i].childNodes.length){
                            if (cycleOBJ[nodeChilds[i].tagName]==null){
                                cycleOBJ[nodeChilds[i].tagName]=new Object;
                                buildObjectNode(cycleOBJ[nodeChilds[i].tagName],nodeChilds[i]);
                            }else{
                                if (cycleOBJ[nodeChilds[i].tagName].length){
                                    cycleOBJ[nodeChilds[i].tagName][cycleOBJ[nodeChilds[i].tagName].length]=new Object;
                                    buildObjectNode(cycleOBJ[nodeChilds[i].tagName][cycleOBJ[nodeChilds[i].tagName].length-1],nodeChilds[i]);
                                }else{
                                    cycleOBJ[nodeChilds[i].tagName]=[cycleOBJ[nodeChilds[i].tagName]];
                                    cycleOBJ[nodeChilds[i].tagName][1]=new Object;
                                    buildObjectNode(cycleOBJ[nodeChilds[i].tagName][1],nodeChilds[i]);
                                }
                            }
                        }else{
                            cycleOBJ[nodeChilds[i].tagName]=nodeChilds[i][nodeText];
                        }
                    }
                }
            }
        }
    }
}

$(document).ready(function () {
    setbuttom();

    //setcollap2();
});

