iwms.imgPage=true;

// 滚屏 ===== begin =====
var currentpos,timer;
function initializeScroll() { timer=setInterval("scrollwindow()",80);} 
function scrollclear(){clearInterval(timer);}
function scrollwindow() {currentpos=document.documentElement.scrollTop;window.scroll(0,++currentpos);if (currentpos != document.documentElement.scrollTop) scrollclear();} 
document.onmousedown=scrollclear;
document.ondblclick=initializeScroll;
//  滚屏 ===== end =====


// 内容样式 ===== begin =====
function ContentSize(size)
{
	var obj=document.getElementById("content");
	obj.style.fontSize=size>0 ? size+"px" : "";
	if (arguments.length==1){
		iwms.setCookie("iwmsFontSize",size,size==0?-1:1);
	}
}
function WriteBg()
{
	var a=["#EDF0F5","#FAFBE6","#FFF2E2","#FDE6E0","#F3FFE1","#DAFAF3","#EAEAEF","#FFF"]
	for(var i=0;i<a.length;i++){
		document.write("<img src='"+ iwms.urlPrefix +"pic/b.gif' style='cursor:pointer;width:7px;height:6px;border:1px solid #999;background:"+ a[i] +"' alt='"+(i==a.length-1?"默认":a[i])+"' onclick='ContentBg(\""+(i==a.length-1?"":a[i])+"\")'/> ");
	}
}
function ContentBg(color)
{
	var obj=document.getElementById("bodyTd");
	obj.style.backgroundColor=color;
	if (arguments.length==1){
		iwms.setCookie("iwmsContBg",color,color.length==0?-1:1);
	}
}
function InitContStyle()
{
	if (v);
	var v=iwms.getCookie("iwmsFontSize");
	if (v.length>0){
		ContentSize(v,false);
	}
	v=iwms.getCookie("iwmsContBg");
	if (v.length>0){
		ContentBg(v,false);
	}
}
// 内容样式 ===== end =====

// 显示编辑链接===== begin =====
function editLink(nid,mname)
{
	if(iwms.getCookie("iwmsAdm").length>0 || mname==iwms.getCookie("iwmsUser") && iwms.getCookie("iwmsPass").length>0){
		document.write('<a href="'+iwms.urlPrefix+'membernewsAdd.aspx?id='+nid+'" target="_blank" class="edit">编辑</a>');
	}
}
// 显示编辑链接===== end =====

// 打印 ===== begin =====
function doPrint()
{
	var adBegin="<!--IWMS_AD_BEGIN-->";
	var adEnd="<!--IWMS_AD_END-->";
	var body;
	var css;
	var str;
	str += "<style media=print>.Noprint{display:none;}.PageNext{page-break-after: always;}</style>";
	str = "\n<script type='text/javascript'>\r\nfunction doPrint(){window.print();}\r\n</script>\r\n";
	str += "<center class='Noprint'><p><object id='WebBrowser'  classid='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'  height='0'  width='0'></object>";
	str += "<input type='button' value='打印' onclick='document.all.WebBrowser.ExecWB(6,1)'> ";
	str += "<input type='button' value='直接打印' onclick='document.all.WebBrowser.ExecWB(6,6)'> ";
	str += "<input  type='button' value='页面设置' onclick='document.all.WebBrowser.ExecWB(8,1)'> ";
	str += "</p><p><input type='button' value='打印预览' onclick='document.all.WebBrowser.ExecWB(7,1)'> ";
	str += "[字体：<input type='button' value='大' onclick='javascript:ContentSize(16)'> <input type='button' value='中' onclick='javascript:ContentSize(14)'> <input type='button' value='小' onclick='javascript:ContentSize(12)'>]";
	str += "</p><hr align='center' width='90%' size='1' noshade='noshade'></center>";
	str += "<div id=\"con\" contenteditable='true'>";
	body= document.getElementById("printBody").innerHTML;
	//去掉广告
	if (body.indexOf(adBegin)>=0)
	{
		str+=body.substr(0,body.indexOf(adBegin));
		str+=body.substr(body.indexOf(adEnd)+adEnd.length,body.length);
	}else{
		str+=body;
	}
	str +="</div>";
	document.body.innerHTML=str;
}
// 打印 ===== end =====

// 静态ajax取数据 ===== begin =====
iwms.getVars = function(){
	var x = new Ajax('XML');
	var queryString="act=ajax&cmd=newsVars&aid="+iwms.aId;
	x.post(iwms.urlPrefix+'ajax.aspx',queryString,function(r){
		with(r.documentElement){
			iwms.hits=parseInt(getElementsByTagName("hits")[0].firstChild.data);
			iwms.diggs=parseInt(getElementsByTagName("digg")[0].firstChild.data);
		}
		iwms.dispVars();
//		alert(remark.user+","+iwms.hits+","+iwms.diggs);
	}
	);
}

// 显示点击数和digg
iwms.dispVars = function(){
	if (iwms.hits){
		var o = document.getElementById("news_hits");
		if (o){
			o.innerHTML=iwms.hits;
		}
	}
	if (iwms.diggs){
		var o=document.getElementById("digg");
		if(o){
			var ds=o.getElementsByTagName("LI");
			ds[0].innerHTML=iwms.diggs;
			if(iwms.getCookie("iwmsDigged").sInclude(iwms.aId)){
				var a=ds[1].childNodes[0];
				a.innerHTML="已投票!";
				a.onclick=function(){return false;};
				a.style.color="#999";
			}
		}
	}
};
// 静态ajax取数据 ===== end =====

// 发邮件 ===== begin =====
function mail(){
}

mail.sourceEle=null;
mail.container=null;
mail.shadows=new Array();
mail.smtp=false;

// 显示邮件表单
mail.disp=function(ele)
{
	if (mail.container){
		var o=mail.container;
		mail.sourceEle=ele;
		if (o.style.display=="none" || o.style.display==""){
			var pos=iwms.msgPos(ele,o);
			document.fmMail.reset();
			o.style.position="absolute";
			o.style.left=pos.x+"px";
			o.style.top=pos.y+"px";
			o.style.zIndex=96;
			o.style.display="block";
			iwms.dropShadow("mail",o);
		}else{
			iwms.clearShadow("mail");
			o.style.display="none";
		}
	}else{
		var x = new Ajax('XML',ele);
		x.get(iwms.urlPrefix+'mail.xml',function(r){
			var html=(r.documentElement.getElementsByTagName("html")[0].firstChild.data);
			var o=document.createElement("DIV");
			o.className="aj_form";
			o.innerHTML=html;
			document.body.appendChild(o);
			mail.container=o;
			mail.disp(ele);
		}
		);
		return;
	}
}

// 提交邮件推荐
mail.post=function()
{
//	mail.smtp=true;
	var ofm=document.fmMail;
	if (ofm.sender.value=="")
	{	alert("发件人必须填写");
		ofm.sender.focus();
		return false;
	}
	if (ofm.mailFrom.value=="" || !mail.valid(ofm.mailFrom.value))
	{	alert("请正确填写你的邮箱");
		ofm.mailFrom.focus();
		return false;
	}
	if (ofm.mailTo.value=="" || !mail.valid(ofm.mailTo.value))
	{	alert("请正确填写收信人邮箱");
		ofm.mailTo.focus();
		return false;
	}

	if (!mail.smtp){
		var url="mailto:"+ ofm.mailTo.value +"?cc="+ ofm.mailCc.value +"&subject="+ ofm.sender.value +" 向你推荐篇文章:"+ document.title +"&body=您好:%0D%0A%0D%0A　　"+ window.location;
		window.location.href=url;
		mail.disp();
		return false;
	}

	var x = new Ajax('XML',mail.sourceEle);
	var queryString="act=ajax&cmd=mail&url="+ escape(document.location.href) +"&"+Ajax.getFormData(ofm);
	x.post(iwms.urlPrefix+'mail.aspx',queryString,function(r){
		var success=r.documentElement.getElementsByTagName("success")[0].firstChild.data=="1";
		if (success){
			x.message("邮件成功发送",2000);
			mail.disp();
		}else{
			x.message("邮件发送失败",2000);
		}
	}
	);
	return false;
	
}

// 测试邮件格式是否正确
mail.valid=function(address)
{
	if (address.length==0){
		return false;
	}
	var re=new RegExp("^\\w+([\\-\\.]\\w+)*@\\w+([\\-\\.]\\w+)*(\\.\\w+)+$","ig");
	return re.test(address);
}
// 发邮件 ===== end =====

// 收藏链接 ===== begin =====
var fav=new Object();
fav.disp=function(ele){
	if(!fav.container){
		var html="<div class='aj_title'><div style='float:left'>收藏 &amp; 分享</div><div class='aj_close'><a href='###' onclick='fav.hide()'>x</a></div></div><iframe src='"+iwms.urlPrefix+"frm_fav.htm' frameborder='0' style='width:465px;height:100px'></iframe>";
		var o=document.createElement("DIV");
		o.innerHTML=html;
		fav.container=o;
	}
	iwms.popMsg("fav",ele,fav.container);
};
fav.hide=function(){
	iwms.hideMsg("fav");
};
// 收藏链接 ===== end =====