<!DOCTYPE html>
<html>
<head>
<title>mmmy</title>
<#include "./module/public/head.ftl"/>
<style>
.poster {
	position: absolute;
	left: 250px;
	width: 100px;
	height: 100px;
	opacity: 0.7;
	color: rgba(0, 0, 0, 0.9);
	-webkit-border-radius: 10px;
	background-color: #835A99;
}
</style>
</head>
<body class="HolyGrail">

	<header>h</header>
	<div class="HolyGrail-body">
		<div class="HolyGrail-content" style="">
			<div id="fanBulletId" class="fan-bullet"
				style="height: 500px; min-width: 200px">
				<div style="width: 100%; height: 100%;"></div>
				<!-- <div class="fan-bullet_area"
					style="background-color: gray; opacity: 0.3;">
					<div style="width: 100px;height: 50px;background-color: red;opacity: 1;">
					</div>
					<div style="width: 100px;height: 50px;background-color: red;opacity: 1;">
					</div>
				</div> -->
			</div>
		</div>
		<nav class="HolyGrail-nav">2</nav>
		<aside class="HolyGrail-ads">3</aside>
	</div>
	<footer><input type="text" id="msgId"><button onclick="sendMsg();" >发送</button></footer>

	<!-- <div id="demo" class="poster"
		v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' ,left:left + 'px'}">
		<input v-model="val" /> {{status}}
	</div>
	<div id="app">
		<p>{{ foo }}</p>
		这里的 `foo` 不会更新！
		<button v-on:click="aa('aaaa')">Change it</button>
	</div>
	message:${message} -->
	<#include "./module/public/js.ftl"/>
</body>
<script>
	var socket; 

	window.onload = function() {
		var fanBullet = new FanBullet("fanBulletId", {
			height : "100%"
		});
		/* var bullet = new Bullet({
			text : "aaa",
			fontSize : "50px",
			velocity:10,
			top:"20px",
		}, fanBullet);
		fanBullet.addBullet(bullet); */
		
		var getBullet = function() {
			fanBullet.el.style.backgroundColor = "#"+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))
			/* for(var i=0;i<10;i++){
				var bullet = new Bullet({
					backgroundColor: "#"+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16)),
					color: "#"+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16)),
					text : i+"4djskjalsdkjasldkaslj",
					fontSize : Math.random()*30+10+"px",
					velocity:Math.random()*20,
					top:parseInt(fanBullet.bulletAreaDiv.offsetHeight)*Math.random()+"px",
				}, fanBullet);
				fanBullet.addBullet(bullet);
			} */
		}
		
		function putBullet(cfg){
			var bullet = new Bullet({
				backgroundColor: "#"+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16)),
				color: "#"+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16))+(Math.floor(Math.random()*256).toString(16)),
				text : cfg.text,
				fontSize : Math.random()*30+10+"px",
				velocity:Math.random()*20,
				top:parseInt(fanBullet.bulletAreaDiv.offsetHeight)*Math.random()+"px",
			}, fanBullet);
			fanBullet.addBullet(bullet);
		}
		
		var timer = window.setInterval(getBullet,5000);
		
		var hiddenProperty = 'hidden' in document ? 'hidden' :    
		    'webkitHidden' in document ? 'webkitHidden' :    
		    'mozHidden' in document ? 'mozHidden' :    
		    null;
		var visibilityChangeEvent = hiddenProperty.replace(/hidden/i, 'visibilitychange');
		var onVisibilityChange = function(){
		    if (!document[hiddenProperty]) {    
		    	timer = window.setInterval(getBullet,5000);
		    }else{
		    	window.clearInterval(timer);
		    }
		}
		document.addEventListener(visibilityChangeEvent, onVisibilityChange);
		
		
		 
	    if(typeof(WebSocket) == "undefined") {  
	        console.log("您的浏览器不支持WebSocket");  
	    }else{  
	        console.log("您的浏览器支持WebSocket");  
	          
	        //实现化WebSocket对象，指定要连接的服务器地址与端口  建立连接  
	        socket = new WebSocket("ws://"+document.location.host+"/test0/websocket");  
	        //打开事件  
	        socket.onopen = function() {  
	            console.log("Socket 已打开");  
	            socket.send("这是来自客户端的消息" + location.href + new Date()+document.location.host);  
	        };  
	        //获得消息事件  
	        socket.onmessage = function(msg) {  
	            console.log(msg.data); 
	            
	            putBullet({text:msg.data})
	            
	            //发现消息进入    调后台获取   
	        };  
	        //关闭事件  
	        socket.onclose = function() {  
	            console.log("Socket已关闭");  
	        };  
	        //发生了错误事件  
	        socket.onerror = function() {  
	            alert("Socket发生了错误");  
	        }  
	        window.onunload = function(){  
	              socket.close();  
	            }

	    }
		
		
	}
		
		
	function sendMsg(){
		socket.send(document.getElementById("msgId").value);  
	}
	
	
	/* new Vue({
		el : '#demo',
		data : {
			show : true,
			activeColor : 'yellow',
			fontSize : 30,
			left : 0,
			val:'',
			status:false
		},
		watch: {
		    // 如果 `question` 发生改变，这个函数就会运行
		    val: function (newQuestion, oldQuestion) {
		    	this.status = /^[0-9]+(.[0-9]+)?(px|%)$/g.test( this.val );
		    }
		},
		mounted : function() {
			//setInterval(this.leftm, 100);
		},
		methods : {
			color : function() {
				//this.fontSize = this.fontSize + 1;
			},
			leftm : function() {
				if(this.left==20){
					//this.$destroy()
				}
				this.left = this.left + 1;
			},
			testinput : function(){
				//alert(/^([1-9]+|0)[.]?\d*(px|%)$/g.test( val ));
			}
		}
	})

	var obj = {
		foo : 'bar'
	}

	//Object.freeze(obj)

	new Vue({
		el : '#app',
		data : obj,
		methods : {
			aa : function(a) {
				alert(a);
			}
		}
	})

	function aaa() {
		alert(1);
	} */
</script>
</html>