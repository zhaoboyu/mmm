webpackJsonp([0],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	/**
	 * Created by linglingling on 16/11/17.
	 */
	__webpack_require__(1);
	const template = __webpack_require__(2);
	const CTTXPlugin = __webpack_require__(3);
	var commScroll = null;
	//var networkUrl = "http://192.9.202.99:8080/NGOSS_Front/mobilecall_call";
	var networkUrl = "http://222.73.7.130:8080/NGOSS_Front/mobilecall_call";
	// var networkUrl = "http://192.168.1.121:8080/NGOSS_Front/mobilecall_call";
	// var networkUrl = "http://222.73.7.131:7680/NGOSS_Front/mobilecall_call";


	// 获取数据接口

	var GetintentMessage = function (send_json_ed) {
	    $.post(networkUrl, {"msg": JSON.stringify(send_json_ed)},
	        function (msg) {
	            var intmsg = msg.intentMessage;
	            var jsonintent = JSON.parse(intmsg);
	            console.log(jsonintent);
	            var obj_new = {};
	            var arr_amountType = [];
	            $.each(jsonintent, function (Name, Value) {
	                if(Name == 'IncludeAmountType'){
	                    arr_amountType = Value.split(',');
	                    window.localStorage.setItem('includeAmount',arr_amountType);
	                }
	                if(Name == 'CustomerType'){
	                    window.localStorage.setItem('cus_sel',Value);
	                }
	                if(Name == 'BusinessTerm'){
	                    window.localStorage.setItem('bus_term_sel',Value);
	                }
	                // alert(arr_amountType);
	                obj_new[Name] = Value;
	                var classname = "."+Name;
	                var clasN = $(classname).attr("value");
	                    $(classname).attr("value",Value);
	                var idName = "#" + Name;
	                $(idName).val(Value);
	                if (Name == "BusinessType") {
	                    $(classname).val($(classname).attr("data-v"));
	                }
	                if (Name == "OperateOrgID") {
	                    $(classname).val($(classname).attr("data-v"));
	                }
	                if (Name == "AsUserID") {
	                    $(classname).val(Value);
	                }
	                if(Name == "CustomerType") {
	                    window.localStorage.setItem('origin_cus_type',Value);
	                }
	                if(Name=='DealerInvoice'){
	                    $(idName).val($(idName).attr('data-val'));
	                }
	                var sel_name = 'select[data-id="'+ Name +'"]';
	                var sel_id = $(sel_name).children("option").attr('data-ser-id');
	                var sel_losing = $(sel_name).attr('data-losing');
	                if(Value!=""&&sel_losing == '0'){
	                    if(sel_id == Value){
	                        $(sel_id).attr("selected","true");
	                    }
	                }else if(Value!=""&&sel_losing == '0') {
	                    if(sel_id == Value){
	                        $(sel_id).attr("selected","true");
	                    }
	                }
	            });
	            var obj_new_str = JSON.stringify(obj_new);
	            window.localStorage.setItem('obj_later',obj_new_str);
	        },
	        "json")
	}

	$('#section_container').on('pageshow','#application_informationT', function () {
	    var height = $(window).height() - $('#application_information_contentT').prev().height() - $('.application_information_contentC').prev().height() - $('.footer').height() - $('.note_information').height();

	    $('.whiteBG').css('height',height);
	        // 获取当前登录用户的信息和客户信息
	        CTTXPlugin.getUserModelInfo(function (msg) {
	            var user_info = msg.userInfo;
	            var currentuser = user_info.userDesc;
	            window.localStorage.setItem("current_user",currentuser);
	            var current_userCode = user_info.userName;
	            window.localStorage.setItem("current_userCode",current_userCode);
	        });

	        var intentId = null;
	        var roleInformation = null;
	        var Customertype_nice = null;
	        var productId = null;
	        var Customer_ID = null;
	        CTTXPlugin.LookApply(function (msg) {
	            console.log("LookApplyb001.05:",msg);
	                var intent_ID = msg.intentID;
	                var pro_ID = msg.productID;
	                var send_json_ed = {
	                    SYS_HEAD: {TransServiceCode: 'agree.ydjr.b001.05', Contrast: 'AAAAAAAAAAAAAAAA'},
	                    ReqInfo: {
	                        //customerID: '012369d3-e499-4a60-a3cb-30d4cf508349',
	                        productID: pro_ID,
	                        intentID: intent_ID
	                    }
	                };
	                CTTXPlugin.customerIntrestInfoPass(function (msg) {
	                    var selfOrAgent = msg[6];
	                    var stateLent = msg[7];
	                    intentId = msg[8];
	                    Customertype_nice = msg[9];
	                    productId = msg[1];
	                    Customer_ID = msg[2];
	                    roleInformation = msg[5];
	                    GetintentMessage(send_json_ed);
	                    // 查询接口
	                    var current_user = localStorage.getItem("current_user");
	                    var current_userCode = localStorage.getItem("current_userCode");
	                    var origin_cus_type = localStorage.getItem("origin_cus_type");
	                    var send_json = {
	                        SYS_HEAD: {TransServiceCode: 'agree.ydjr.g001.04', Contrast: 'AAAAAAAAAAAAAAAA'},
	                        ReqInfo: {
	                            //customerID: '012369d3-e499-4a60-a3cb-30d4cf508349',
	                            customerID: Customer_ID,
	                            productID: productId,
	                            intentID: intentId,
	                            customerType: origin_cus_type,
	                            currentUser:current_user,
	                            currentUserCode:current_userCode
	                        }
	                    };


	                    // 获取模版报文
	                    $.ajax({
	                        url:networkUrl,
	                        type:'POST',
	                        data:"msg="+JSON.stringify(send_json),
	                        dataType:"json",
	                        success:function (data) {
	                            var $data = data;
	                            console.log("查看申请书模版报文obj:",data);
	                            var msgstr=JSON.stringify(data);
	                            console.log("查看申请书模版报文",msgstr);

	                            for (var j = 0; j < data.applys.length; j++) {
	                                var item = data.applys[j];
	                                for (var l = 0; l < item.details.length; l++) {
	                                    var itemDetail = item.details[l];
	                                    var applyValue = itemDetail.applyValue;
	                                    var applyName = itemDetail.applyName;
	                                    var applyValueName = itemDetail.applyValueName;
	                                    var applyDefaultValue = itemDetail.applyDefaultValue;
	                                    if (itemDetail.applyCategory == 'inp') {
	                                        var a = applyValue.split('.');
	                                        var b = applyValueName.split('.');
	                                        if (applyValue) {
	                                            itemDetail.applyValue = (data[a[0]])[a[1]];
	                                            if (applyValueName) {
	                                                itemDetail.applyValueName = (data[b[0]])[b[1]];
	                                            }

	                                            var tplHmtllT = template('application_informationT', data);
	                                            $('#application_informationT').html(tplHmtllT);
	                                            $('.content_introduction li[sys="SystemChannelFlag"]').css("display", "none");
	                                            commScroll = new iScroll('commScroll_scrollerT');
	                                            commScroll.refresh();

	                                        }
	                                    } else if (itemDetail.applyCategory == 'sel' || itemDetail.applyCategory == 'che'|| itemDetail.applyCategory == 'fuz') {

	                                        var text_json = {
	                                            SYS_HEAD: {TransServiceCode: 'agree.ydjr.d001.01', Contrast: 'AAAAAAAAAAAAAAAA'},
	                                            ReqInfo: {
	                                                dictitem: itemDetail.applyValue
	                                            }
	                                        }

	                                        var dictInfo =
	                                        {
	                                            "idsCategory": []
	                                        };
	                                        if(applyDefaultValue=='') {
	                                            var obj_used = JSON.parse(localStorage.getItem('obj_later'));
	                                            $.each(obj_used,function (n, v) {
	                                                if(itemDetail.applyName == n) {

	                                                    itemDetail.applyDefaultValue = v;
	                                                }
	                                            })
	                                            var tplHmtll = template('information_templateT', data);
	                                            $('#information_templateT').html(tplHmtll);
	                                            $('.content_introduction li[sys="SystemChannelFlag"]').css("display", "none");

	                                        }else if(applyDefaultValue) {
	                                            if(applyName == "CustomerType") {
	                                                var cus_selected = localStorage.getItem('cus_sel');
	                                                itemDetail.applyDefaultValue = cus_selected;
	                                            }
	                                            if(applyName == "BusinessTerm") {
	                                                var bus_term_selected = localStorage.getItem('bus_term_sel');
	                                                itemDetail.applyDefaultValue = bus_term_selected;
	                                            }

	                                            if(itemDetail.applyCategory == 'che'){
	                                                var includes = localStorage.getItem('includeAmount');
	                                                var include_arr = [];
	                                                include_arr = includes.split(',');
	                                                itemDetail.applyDefaultValue = include_arr;
	                                            }

	                                        }

	                                        if(applyValue.indexOf('.')>-1){
	                                            var b = applyValue.split('.');
	                                            dictInfo.idsCategory.push((data[b[0]])[b[1]]);
	                                            itemDetail.applyValue = dictInfo;
	                                            var tplHmtllT = template('application_informationT', data);
	                                            $('#application_informationT').html(tplHmtllT);
	                                            $('.content_introduction li[sys="SystemChannelFlag"]').css("display", "none");
	                                            commScroll = new iScroll('commScroll_scrollerT');
	                                            commScroll.refresh();
	                                        }
	                                        else {
	                                            $.ajax({
	                                                type: "post",
	                                                url: networkUrl,
	                                                data: "msg=" + JSON.stringify(text_json),
	                                                async: false,
	                                                dataType: "text",
	                                                success: function (data) {
	                                                    dictInfo.idsCategory.push(JSON.parse(data));
	                                                    itemDetail.applyValue = dictInfo;
	                                                    var tplHmtllT = template('application_informationT', $data);
	                                                    $('#application_informationT').html(tplHmtllT);
	                                                    $('.content_introduction li[sys="SystemChannelFlag"]').css("display", "none");
	                                                    commScroll = new iScroll('commScroll_scrollerT');
	                                                    commScroll.refresh();

	                                                }
	                                            });
	                                        }
	                                    }

	                                    $('select').each(function () {
	                                        if($(this).attr('data-id') =="TaxpayerType") {
	                                            if($(this).children('option:selected')){
	                                                if($(this).children('option:selected').attr('data-ser-id')=='01'){
	                                                    $('.content_introduction li[sys="InvoiceHeader"]').css('display','none');
	                                                    $('.content_introduction li[sys*="InvoiceAccount"]').css('display','none');
	                                                    $('.content_introduction li[sys*="InvoiceAddTel"]').css('display','none');
	                                                    $('.content_introduction li[sys*="InvoiceSendAddress"]').css('display','none');
	                                                }else {
	                                                    $('.content_introduction li[sys="InvoiceHeader"]').css('display','inline-block');
	                                                    $('.content_introduction li[sys*="InvoiceAccount"]').css('display','inline-block');
	                                                    $('.content_introduction li[sys*="InvoiceAddTel"]').css('display','inline-block');
	                                                    $('.content_introduction li[sys*="InvoiceSendAddress"]').css('display','inline-block');
	                                                }

	                                            }
	                                        }
	                                    })
	                                    /*新增模糊查询的分支判断start*/
	                                    if (itemDetail.applyCategory == 'fuz') {
	                                        var obj_used_fuz = JSON.parse(localStorage.getItem('obj_later'));
	                                        $.each(obj_used_fuz, function (n, v) {
	                                            if (itemDetail.applyName == n) {
	                                                var fuz_appName = '#'+itemDetail.applyName;
	                                                var fuz_option = $(fuz_appName).next('.fuzzy_sel').children('option');
	                                                for(var i=0;i<fuz_option.length;i++){
	                                                    var fuz_single_opt_val = $(fuz_option[i]).attr('data-ser-id');
	                                                    var fuz_single_opt_name = $(fuz_option[i]).attr('data-ser-name');
	                                                    if(fuz_single_opt_val==v){
	                                                        itemDetail.applyDefaultValue = fuz_single_opt_name;

	                                                        // $(fuz_appName).val(fuz_single_opt_name);
	                                                        break;
	                                                    }

	                                                }

	                                            }
	                                        })
	                                    }
	                                    /*新增模糊查询的分支判断end*/


	                                }
	                            }
	                            GetintentMessage(send_json_ed);
	                            $('.whiteBG').hide();

	                        },
	                        error:function () {
	                            A.showToast("查看申请信息超时,请稍后重试");
	                        }
	                    });

	                });

	            },
	            function () {
	                alert('failure' + msg);
	            });

	});



/***/ }
]);