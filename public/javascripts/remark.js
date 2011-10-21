function remark(){
}

remark.container=null;		// 表单所在div
remark.sourceEle=null;		// 开启表单的链接
remark.faceTimer=null;		// 显示表情定时隐藏
remark.reId=0;			// 回复的评论id
remark.user=iwms.getCookie("iwmsUser");

// 评论投票
remark.vote = function(ele,rid,s){
	var x = new Ajax('XML',ele);
	var voted = iwms.getCookie("iwmsRVoted");
	voted = voted.length==0 ? [] : voted.split(',');
	if (voted.include(rid)){
		x.message("您已经对该评论投过票!",2000);
		return;
	}
	
	var queryString = 'act=ajax&cmd=vote&rid='+escape(rid)+'&support='+s;
	x.post(iwms.urlPrefix+'remark.aspx',queryString,function(r){
		var success=(r.documentElement.getElementsByTagName("success")[0].firstChild.data=="1");
		if (success){
			x.message("谢谢您参与投票!",2000);
		}else{
			x.message("评论已不存在，提交失败!",2000);
		}
		if(voted.length>9){
			voted=voted.slice(voted.length-9);
		}
		voted.push(rid);
		iwms.setCookie("iwmsRVoted",voted.toString(),30);
		ele.innerHTML="已"+ele.innerHTML;
		ele=ele.nextSibling;
		var n = parseInt(ele.innerHTML.replace(/\D/g,""));
		ele.innerHTML="&nbsp;("+(n+1)+")";
		
	//	alert(ele+","+ele.tagName+":"+ele.innerHTML+","+parseInt(ele.innerHTML.replace(/\D/g,"")) );
	}
	);
};

// 页面插入新评论
remark.add = function(r)
{
	var str="<div class='reHead'><div class='reLayer'>第 "+
		r.layer+" 楼</div><img src='"+ iwms.urlPrefix +"pic/b.gif' class='face"+
		r.face+"' alt=''/> <span class='reName'>"+
		r.username+"</span> 发表于 <span class='reDate'>"+
		r.date+"</span></div><div class='reBody'>"+
		r.body+"</div><div class='reFun'><a href='###'>回复</a> <a href='###'>支持</a> (0) <a href='###'>反对</a> (0)</div>";
	var o=$i("reContainer");
	if (o){
		$(o).prepend(str);
	}
};

// 显示评论表单
remark.disp = function(ele, rid)
{
	if (remark.container){
		var sourceChg=false;	// 事件源改变的话直接显示
		var o=remark.container;
		if (remark.sourceEle && ele && remark.sourceEle!=ele){
			sourceChg=true;
		}
		remark.sourceEle=ele;
		if (o.style.display=="none" || o.style.display=="" || sourceChg){
			var o_f=document.fmRemark;
			remark.user=o_f.username.disabled ? "" : o_f.username.value;
			o_f.reset();
			if(remark.user.length==0){
				$i("rmAnonymity").click();
			}else{
				o_f.username.value=remark.user;
			}
			var pos=iwms.msgPos(ele,o);
			with(o.style){
				left=pos.x+"px";
				top=pos.y+"px";
				display="block";
				zIndex=100;
			}
			remark.reId=rid ? rid : 0;
			iwms.dropShadow("remark",o);
		}else{
			iwms.clearShadow("remark");
			o.style.display="none";
			
		}
	}else{
		var x = new Ajax('XML',ele);
		x.get(iwms.urlPrefix+'remark.xml',function(r){
			var html=(r.documentElement.getElementsByTagName("html")[0].firstChild.data);
			remark.container=document.createElement("DIV");
			remark.container.className="aj_form";
			remark.container.innerHTML=iwms.urlPrefix.length==0 ? html : html.replace("pic/b.gif",iwms.urlPrefix+"pic/b.gif");
			document.body.appendChild(remark.container);
			if (remark.user.length>0){
				document.fmRemark.username.value=remark.user;
			}
			remark.disp(ele, rid);
		}
		);
		return;
	}
};

// 设置匿名
remark.anony = function(o_c)
{
	var o_f=o_c.form;
	var o_n,os;
	os=o_f.getElementsByTagName("INPUT")
	for(var i=0;i<os.length;i++){
		o_n=os[i];
		if(o_n.name=="username"){
			break;
		}
	}
	if (o_n==null){
		return;
	}
	if (o_c.checked){
		o_n.value="匿名";
		o_n.disabled=true;
	}else{
		o_n.value=remark.user;
		o_n.disabled=false;
	}
};

// ctrl+enter提交
remark.handle = function(e,ele){
	if (e.ctrlKey && e.keyCode==13){
		remark.post(ele.form);
		return false;
	}else{
		return true;
	}
};

// 显示内容长度
remark.dispLen = function(obj){
	$(obj.form).find("input[id^='bodyLen']").val(obj.value.length);
};

// 显示表情
remark.dispFace = function(ele)
{
	window.clearTimeout(remark.faceTimer);
	var fname=$(ele).parent("form:first").attr("name");	// 表单名
	o=$i("iwmsRemarkFace");
	if (o==null){
		o=document.createElement("DIV");
		o.id="iwmsRemarkFace";
		with(o.style){
			display="none";
			position="absolute";
			border="1px solid #999";
			padding="3px";
			background="#FAFAD2";
			font="9pt 宋体 arial";
			color="#000";
			whiteSpace="nowrap";
			if (typeof(opacity)=="string"){
				opacity="0.7";
			}else{
				filter="alpha(opacity=70)"
			}
			zIndex=103;
		}
		o.onmouseout=function(){remark.hideFace()};
		o.onmouseover=function(){if (remark.faceTimer!=null)window.clearTimeout(remark.faceTimer);};
		ele.ownerDocument.body.appendChild(o);
	}
	if (o.style.display=="none"){
		var txt="";
		for(var i=1; i<19; i++){
			txt+="<img src='"+ iwms.urlPrefix +"pic/b.gif' class='face"+ i +"' style='border:2px solid #FAFAD2;margin:3px' onclick='remark.pickFace(this,"+i+",\""+fname+"\")' onmouseover=\"this.style.borderColor='#DEB887';\" onmouseout=\"this.style.borderColor='#FAFAD2';\"/>";
			if (i==9){
				txt+="<br/>";
			}
		}
		o.innerHTML=txt;
		var pos=iwms.msgPos(ele,o);
		o.style.left=pos.x+"px";
		o.style.top=pos.y+"px";
		// 高亮当前表情
		for(var i=0; i<o.childNodes.length; i++){
			if (o.childNodes[i].className==ele.className){
				o.childNodes[i].style.backgroundColor="#DEB887";
				break;
			}
		}
		o.style.display="block";
	}
};

// 隐藏表情
remark.hideFace = function()
{
	if (remark.faceTimer!=null){
		window.clearTimeout(remark.faceTimer);
	}
	remark.faceTimer=window.setTimeout(function(){var o=$i('iwmsRemarkFace');if(o){o.style.display='none';}},1000);
};

// 选择表情
remark.pickFace = function(ele,n,fname)
{
	var fm=document.forms[fname];
	var o_face=fm.face;
	var jq_faceView=$(fm).find("img[class^='face']:first");
	o_face.value=n;
	jq_faceView.attr("class",ele.className);
	$i("iwmsRemarkFace").style.display="none";
	if (remark.faceTimer!=null){
		window.clearTimeout(remark.faceTimer);
	}
};

// 显示评论协议
remark.dispAgreement = function()
{
	var o=document.fmRemark.nextSibling;
	o.style.display = o.style.display=="none" ? "block" : "none";
	iwms.dropShadow("remark",remark.container);
};

// 提交评论
remark.post = function(fm)
{
	if (iwms.getCookie("remarked").length>0){
		alert("为防灌水,请稍后重发");
		return false;
	}
	if (!$(fm).find("input[id^='rmAgree']:first").attr("checked")){
		alert("只有同意本站评论声明才可发布");
		return false;
	}
	if (fm.username.value==""){
		alert("请填写姓名");
		fm.username.focus();
		return false;
	}
	if (fm.body.value==""){
		alert("请填写评论内容");
		fm.body.focus();
		return false;
	}
	if (fm.body.value.length<remark.minSize){
		alert("评论内容至少"+ remark.minSize +"字");
		fm.body.focus();
		return false;
	}
	if (fm.body.value.length>remark.maxSize){
		fm.body.value = fm.body.value.substr(0,remark.maxSize);
		remark.dispLen(fm.body);
		fm.body.focus();
		alert("评论内容不可以超过"+remark.maxSize+"字,已帮你删除多余部分");
		return false;
	}
	if (fm.username.value.length>10){
		alert("姓名不可以超过10个字");
		fm.username.focus();
		return false;
	}

	var x = new Ajax('XML',remark.sourceEle);
	var queryString="act=ajax&cmd=add&id="+iwms.aId+"&reId="+remark.reId+"&vcode="+iwms.vCode+"&"+Ajax.getFormData(fm);
	x.post(iwms.urlPrefix+'remark.aspx',queryString,function(r){
		var msg=r.documentElement.getElementsByTagName("msg")[0].firstChild.data;
		var json=r.documentElement.getElementsByTagName("json")[0].firstChild.data;
		var interval=parseInt(r.documentElement.getElementsByTagName("interval")[0].firstChild.data);
		if (fm.name=="fmRemark"){
			remark.disp();
		}
		if (interval>0){
			iwms.setCookie('remarked','1',interval/24/360);
		}
		if (json.length>0){
			var r
			eval("r="+json);
			remark.add(r);
//		alert(json);
		}
		x.message(msg,2000);
	}
	);
	return false;
};