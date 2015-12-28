/* global accountDisplayLength */
/* global keyword */
var personInfo = {};
var infoUrl = "MobileAPI.asmx/GetUserInfo";
var infoPara = {
    keyword: keyword,
    username: decodeURIComponent($.urlGet()["name"])
};

var bankCardInfo = {};
var bankRecord = 0;
var bankCardUrl = "MobileAPI.asmx/GetBankCard";
var bankCardPara = {
    keyword: keyword,
    key: $.urlGet()["key"],
    pageIndex: 0,
    pageSize: 10
};

var cashRecord = {};
var cashRecordCount = 0;
var cashRecordUrl = "MobileAPI.asmx/GetCashRecord";
var cashRecordPara = {
    keyword: keyword,
    key: $.urlGet()["key"],
    pageIndex: 0,
    pageSize: 10,
    state: 0,
    mb: 0,
    ma: 1000000,
    dbf: '2012-1-1',
    da: '2025-10-10',
    sr: "",
    zc: "",
    Cz: "",
    tx: "",
    qt: "",
    kw: ""
};

var ocoinRecord = {};
var ocoinRecordCount = 0;
var ocoinRecordUrl = "MobileAPI.asmx/GetOcoinRecord";
var ocoinRecordPara = {
    keyword: keyword,
    key: $.urlGet()["key"],
    pageIndex: 0,
    pageSize: 10,
    mb: 0,
    ma: 1000000,
    dbf: '2012-1-1',
    da: '2025-10-10'
};

$(function () {
    $.loadXML(infoUrl, infoPara, "post", function (xml) {
        var obj = $.xml2json(xml,true);
        personInfo = obj.details[0];
        $('p.accountMoney').html('<span class="inner_title">账户金额：</span>' + personInfo.amount[0]["text"] + "元");
        $('p.ocoin').html('<span class="inner_title">O币数量：</span>' + personInfo.ocoin[0]["text"] + "枚");
        $.loadXML(cashRecordUrl, cashRecordPara, "post", function (xml) {
            var obj = $.xml2json(xml,true);
            var tempList = obj.rowlist;
            console.log(tempList);
            if(tempList == null){
                $('#cashBtn').hide(300);
            }else{
                cashRecord = obj.rowlist[0].row;
                if(cashRecord != null && cashRecord.length>0){
                    $('#cashBtn').show(300);
                    putCashTable();
                }else{
                    $('#cashBtn').hide(300);
                }
            }
        });

        $.loadXML(ocoinRecordUrl, ocoinRecordPara, "post", function (xml) {
            var obj = $.xml2json(xml,true);
            var tempList = obj.rowlist;
            if(tempList == null){
                $('#ocoinBtn').hide(300);
            }else{
                ocoinRecord = obj.rowlist[0].row;
                if(ocoinRecord != null && ocoinRecord.length>0){
                    $('#ocoinBtn').show(300);
                    putOcoinTable();
                }else{
                    $('#ocoinBtn').hide(300);
                }
            }
        });
    });

    loadBankInfo();

    $(document).on('click', '#cash-more', function () {
        setpage2();
    });

    $(document).on('click', '#ocoin-more', function () {
        setpage3();
    });

    $(document).on('click', '#bank-more', function () {
        setpage4();
    });

    $(document).on('click', '#cashBtn', function () {
        setpage2();
    });

    $(document).on('click', '#ocoinBtn', function () {
        setpage3();
    });

    $(document).on('click', '#bankBtn', function () {
        setpage4();
    });

    $(document).on('click', '#newbankbtn', function () {
        newBankCheck();
    });

    $(document).on('click', '#bankBtnPlus', function () {
        $('#newBankModal').modal('show');
        $('#newBankModal input').val("");
        $('#isDefaultBankCheck').prop('checked', false);
    });

    setpage1();
});

var newBankCheck = function () {
    $('#bankNameError').html("");
    var errorStr = ""
    if($('#bankName').val() == ""){
        errorStr += '<p>*银行名字必须填写</p>'
    }

    if($('#bankPersonName').val() == ""){
        errorStr += '<p>*开户人必须填写</p>'
    }

    if($('#bankCardNumber').val() == ""){
        errorStr += '<p>*卡号必须填写</p>'
    }

    if($('#bankLocalName').val() == ""){
        errorStr += '<p>*支行名字必须填写</p>'
    }
    if(errorStr == ""){
        $('#newBankModal').modal('hide');
        var newBankObj = {
            keyword: keyword,
            key: $.urlGet()["key"],
            accountName: $('#bankPersonName').val(),
            BandName: $('#bankName').val(),
            AccountNo: $('#bankCardNumber').val(),
            Accountlocal: $('#bankLocalName').val(),
            isDefault: $('#isDefaultBankCheck').prop('checked') ? 1 : 0
        }
        var newBankUrl = "MobileAPI.asmx/AddBandCard";

        $.loadXML(newBankUrl, newBankObj, "post", function (xml) {
            loadBankInfo();
        });

    }else{
        $('#bankNameError').html(errorStr);
        var t=setTimeout('$("#bankNameError").html("");',5000);
    }
};

var loadBankInfo = function(){
    $.loadXML(bankCardUrl, bankCardPara, "post", function (xml) {
        var obj = $.xml2json(xml,true);
        var tempList = obj.rowlist;
        if (tempList == null) {
            $('#bankBtn').hide(300);
            $('p.bankCard').html('<span class="inner_title">银行卡：</span>' + "您尚无绑定的银行卡");
        } else {
            bankRecord = obj.rowlist[0].row;
            if(bankRecord !=null && bankRecord.length>0){
                $('p.bankCard').html('<span class="inner_title">银行卡：</span>' + obj.totalRecord[0].text + "张");
                $('#bankBtn').show(300);
                putBankTable();
            }else{
                $('#bankBtn').hide(300);
                $('p.bankCard').html('<span class="inner_title">银行卡：</span>' + "您尚无绑定的银行卡");
            }
        }
    });
};

var putCashTable = function () {
    var tableStr = '<table class="table" style="margin-bottom: 0">';
    tableStr += '<thead><tr><th>类型</th><th>金额</th><th>时间</th><th>状态</th></tr></thead><tbody>';
    var length = cashRecord.length > accountDisplayLength ? accountDisplayLength : cashRecord.length;
    var showMore = cashRecord.length > accountDisplayLength;
    for (var i = 0; i < length; i++) {
        tableStr += '<tr>';
        tableStr += '<th>' + cashRecord[i].transaction_Property[0].text + '</th>';
        tableStr += '<th>' + cashRecord[i].transaction_Num[0].text + '</th>';
        tableStr += '<th>' + cashRecord[i].transaction_Time[0].text + '</th>';
        tableStr += '<th>' + cashRecord[i].transaction_Status[0].text + '</th>';
        tableStr += '</tr>';
    }
    tableStr += '</tbody></table>';
    if (showMore) {
        tableStr += '<div id="cash-more" align="center"><a href="#" style="color: #F00">显示更多......</a></div>';
    }
    $('div.cashTable').html(tableStr);
};

var putOcoinTable = function () {
    var tableStr = '<table class="table" style="margin-bottom: 0">';
    tableStr += '<thead><tr><th>类型</th><th>金额</th><th>时间</th><th>状态</th></tr></thead><tbody>';
    var length = ocoinRecord.length > accountDisplayLength ? accountDisplayLength : ocoinRecord.length;
    var showMore = ocoinRecord.length > accountDisplayLength;
    for (var i = 0; i < length; i++) {
        tableStr += '<tr>';
        tableStr += '<th>' + ocoinRecord[i].transaction_Property[0].text + '</th>';
        tableStr += '<th>' + ocoinRecord[i].transaction_Num[0].text + '</th>';
        tableStr += '<th>' + ocoinRecord[i].transaction_Time[0].text + '</th>';
        tableStr += '<th>' + ocoinRecord[i].transaction_Status[0].text + '</th>';
        tableStr += '</tr>';
    }
    tableStr += '</tbody></table>';
    if (showMore) {
        tableStr += '<div id="ocoin-more" align="center"><a href="#" style="color: #F00">显示更多......</a></div>';
    }
    $('div.ocoinTable').html(tableStr);
};

var putBankTable = function () {
    var tableStr = '<table class="table" style="margin-bottom: 0">';
    tableStr += '<thead><tr><th width="60px">开户人</th><th>卡号</th><th>银行</th></tr></thead><tbody>';
    var length = bankRecord.length > accountDisplayLength ? accountDisplayLength : bankRecord.length;
    var showMore = bankRecord.length > accountDisplayLength;
    console.log(bankRecord);

    for (var i = 0; i < length; i++) {
        tableStr += '<tr>';
        tableStr += '<th>' + bankRecord[i].accountname[0].text + '</th>';
        tableStr += '<th>' + bankRecord[i].accountno[0].text + '</th>';
        tableStr += '<th>' + bankRecord[i].bank[0].text + '</th>';
        tableStr += '</tr>';
    }
    tableStr += '</tbody></table>';
    if (showMore) {
        tableStr += '<div id="bank-more" align="center"><a href="#" style="color: #F00">显示更多......</a></div>';
    }
    $('div.bankTable').html(tableStr);
};

var setpage1 = function () {
    $('#page3').fadeOut(300);
    $('#page4').fadeOut(300);
    $('#page2').fadeOut(300, function () {
        $('#page1').fadeIn(300);
        $('html,body').animate({scrollTop:0},'slow');
        window.location.href = 'info://' + "page" + "?" + "page1";
    });
};

var setpage2 = function () {
    $('#page3').fadeOut(300);
    $('#page4').fadeOut(300);
    $('#page1').fadeOut(300, function () {
        $('#page2').fadeIn(300);
        $('html,body').animate({scrollTop:0},'slow');
        showCashFullTable();
        window.location.href = 'info://' + "page" + "?" + "page2";
    });
};

var setpage3 = function () {
    $('#page2').fadeOut(300);
    $('#page4').fadeOut(300);
    $('#page1').fadeOut(300, function () {
        $('#page3').fadeIn(300);
        $('html,body').animate({scrollTop:0},'slow');
        showOcoinFullTable();
        window.location.href = 'info://' + "page" + "?" + "page2";
    });
};

var setpage4 = function () {
    $('#page2').fadeOut(300);
    $('#page3').fadeOut(300);
    $('#page1').fadeOut(300, function () {
        $('#page4').fadeIn(300);
        $('html,body').animate({scrollTop:0},'slow');
        showBankFullTable();
        window.location.href = 'info://' + "page" + "?" + "page2";
    });
};

var showCashFullTable = function () {
    if (cashRecord.length > 0) {
        var tableStr = '';
        for (var i = 0; i < cashRecord.length; i++) {
            tableStr += '<div class="block radius1">';
            tableStr += '<div class="title3 underline1">' +
                cashRecord[i].transaction_Property[0].text + ": " + cashRecord[i].transaction_Num[0].text + '</div>';
//                    tableStr += '<p><span class="inner_title">编码：</span>' + cashRecord[i].transaction_Code + '</p>';
            tableStr += '<p><span class="inner_title">时间：</span>' + cashRecord[i].transaction_Time[0].text + '</p>';
            tableStr += '<p><span class="inner_title">来源：</span>' + cashRecord[i].transaction_Name[0].text + '</p>';
            tableStr += '<p><span class="inner_title">类型：</span>' + cashRecord[i].transaction_Type[0].text + '</p>';
            tableStr += '<p><span class="inner_title">状态：</span>' + cashRecord[i].transaction_Status[0].text + '</p>';
            tableStr += '</div>';
        }
    }
    $('.tcontent#page2').html(tableStr);
};

var showOcoinFullTable = function () {
    if (ocoinRecord.length > 0) {
        var tableStr = '';
        for (var i = 0; i < ocoinRecord.length; i++) {
            tableStr += '<div class="block radius1">';
            tableStr += '<div class="title3 underline1">' +
                ocoinRecord[i].transaction_Property[0].text + ": " + ocoinRecord[i].transaction_Num[0].text + '</div>';
//                    tableStr += '<p><span class="inner_title">编码：</span>' + ocoinRecord[i].transaction_Code + '</p>';
            tableStr += '<p><span class="inner_title">时间：</span>' + ocoinRecord[i].transaction_Time[0].text + '</p>';
            tableStr += '<p><span class="inner_title">来源：</span>' + ocoinRecord[i].transaction_Name[0].text + '</p>';
            tableStr += '<p><span class="inner_title">类型：</span>' + ocoinRecord[i].transaction_Type[0].text + '</p>';
            tableStr += '<p><span class="inner_title">状态：</span>' + ocoinRecord[i].transaction_Status[0].text + '</p>';
            tableStr += '</div>';
        }
    }
    $('.tcontent#page3').html(tableStr);
};

var showBankFullTable = function () {
    if (bankRecord.length > 0) {
        var tableStr = '';
        // var isDefault = parseInt(bankRecord[i].isdefault[0].text) ? "是" : "否";
        for (var i = 0; i < bankRecord.length; i++) {
            tableStr += '<div class="block radius1">';
            tableStr += '<div class="title3 underline1">' + bankRecord[i].bank[0].text + '</div>';
            tableStr += '<p><span class="inner_title">开户人：</span>' + bankRecord[i].accountname[0].text + '</p>';
            tableStr += '<p><span class="inner_title">卡号：</span>' + bankRecord[i].accountno[0].text + '</p>';
            tableStr += '<p><span class="inner_title">支行名：</span>' + bankRecord[i].accountlocal[0].text + '</p>';
            tableStr += '<p><span class="inner_title">是否默认：</span>' + (parseInt(bankRecord[i].isdefault[0].text) ? '是' : '否') + '</p>';
            tableStr += '</div>';
        }
        console.log(tableStr);
    }
    $('.tcontent#page4').html(tableStr);
};