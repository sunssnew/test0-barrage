/**
 * 
 */
function FanBullet(elId,cfg={}) {
	fanLog('-------already in FanBullet____________');
	var fanBullet = this;
	fanBullet.bullets = new Set();
	var el = document.getElementById(elId);
	fanBullet.el = el;
	fanBullet.bulletAreaDiv = document.createElement("div");
	fanBullet.bulletAreaDiv.className = "fan-bullet_area";
	fanBullet.bulletAreaDiv.style.overflow = "hidden";
	if (typeof (cfg.height) != "undefined"){
		fanBullet.bulletAreaDiv.style.height = cfg.height;
	}
	fanBullet.el.appendChild(fanBullet.bulletAreaDiv);
	// function
	fanBullet.addBullet = function(bullet) {
		fanBullet.bulletAreaDiv.appendChild(bullet.bulletDiv);
		fanBullet.bullets.add(bullet);
		bullet.start();
	}
	fanBullet.paly = function() {
		fanBullet.bullets.forEach(function(item, sameItem, set) {
			item.paly();
		});
	}
	fanBullet.stop = function() {
		fanBullet.bullets.forEach(function(item, sameItem, set) {
			item.stop();
		});
	}
	fanBullet.clear = function() {
		fanBullet.bullets.forEach(function(item, sameItem, set) {
			item.bulletDiv.parentNode.removeChild(item.bulletDiv);
			set.delete(item);
		});
	}
	fanLog('-------exit FanBullet__________________');
	return fanBullet;
}

/*
 * { text: fontSize: color: img: }
 */
function Bullet(bcfg, fanBullet) {
	var bullet = this;
	bullet.move={across:1};
	if (typeof(bcfg.text)!= "undefined") {
		bullet.cfg = bcfg;
		if (typeof (bcfg.fontSize) == "undefined") {
			bcfg.fontSize = "10px";
		}
		if (typeof (bcfg.velocity) == "undefined"
			|| typeof (bcfg.velocity) != 'number') {
		bullet.velocity = 10;
		}
		if (typeof (bcfg.top) == "undefined") {
			bcfg.top = 0;
		}
	} else {
		fanLog("参数不对");
		return false;
	}
	var bulletDiv = document.createElement("div");
	bullet.bulletDiv = bulletDiv;
	// bulletDiv.style.height = "100px";
	bulletDiv.style.fontSize = bcfg.fontSize;
	bulletDiv.style.top = bcfg.top;
	bulletDiv.style.position = "absolute";
	bulletDiv.style.whiteSpace = "nowrap";
	if(typeof(bcfg.styleClass) == "string"){
		bulletDiv.className = bcfg.styleClass;
	}
	if(typeof(bcfg.backgroundColor) == "string"){
		bulletDiv.style.backgroundColor = bcfg.backgroundColor;
	}
	if(typeof(bcfg.color) == "string"){
		bulletDiv.style.color = bcfg.color;
	}
	bulletDiv.innerHTML = bcfg.text;
	var bulletAreaDivWidth = parseInt(fanBullet.bulletAreaDiv.offsetWidth);
	function move() {
		var timer = window.setInterval(function() {
			var right = parseInt(bulletDiv.style.right);
			if (!isNaN(right)) {
				if (right > bulletAreaDivWidth) {
					window.clearInterval(timer);
					bulletDiv.parentNode.removeChild(bulletDiv);
					fanBullet.bullets.delete(bullet);
				}
				bulletDiv.style.right = (right + bullet.move.across) + "px";
				fanBullet.bullets.forEach(function(item, sameItem, set) {
					item.collide(bullet);
				});
				bullet.move.across = 1;
			} else {
				window.clearInterval(timer);
			}
		}, bcfg.velocity);
		return timer;
	}
	bullet.stop = function() {
		window.clearInterval(bullet.timer);
	}
	bulletDiv.onmouseover = bullet.stop;

	bullet.paly = function() {
		bullet.timer = move();
	}
	bulletDiv.onmouseout = bullet.paly;
	
	bullet.onclick = function() {
		alert(bcfg.text);
	}
	bulletDiv.onclick = bullet.onclick;
	
	bullet.start = function() {
		bullet.bulletDiv.style.right = "-" + bulletDiv.offsetWidth + "px";
		bullet.timer = move();
	}
	
	bullet.verticalMove = function(num) {
		
		var top = bullet.bulletDiv.offsetTop;
		if(top < 1 || top > fanBullet.bulletAreaDiv.offsetHeight - bullet.bulletDiv.offsetHeight){
			return;
		}
		bulletDiv.style.top = (top + num) + "px";
	}
	
	bullet.collide = function(b) {
		var me = bullet.bulletDiv;
		var he = b.bulletDiv;
		
		var tm = me.offsetTop;  
        var lm = me.offsetLeft;  
        var rm = me.offsetLeft + me.offsetWidth;  
        var bm = me.offsetTop + me.offsetHeight;  

        var th = he.offsetTop;  
        var lh = he.offsetLeft;  
        var rh = he.offsetLeft + he.offsetWidth;  
        var bh = he.offsetTop + he.offsetHeight;  
        
        if(bm<th || lm>rh || tm>bh || rm<lh || bullet===b){
        	// 没碰上 或者是自己
        	// fanLog("没碰上 ")
        }else{  
        	if(bm>bh+1&&th-1>tm){
        		if(Math.abs(tm-th)<Math.abs(bm-bh)){
        			bullet.verticalMove(1);
        			b.verticalMove(-1);
        		}else{
        			bullet.verticalMove(-1);
        			b.verticalMove(1);
        		}
        	}else if(bm>bh){
    			bullet.verticalMove(1);
    			b.verticalMove(-1);
    		}else if(bm<bh){
    			bullet.verticalMove(-1);
    			b.verticalMove(1);
    		}
        }
		
	}
	return bullet;
}

var log = 1;
function fanLog(text) {
	if (log) {
		console.log(text);
	}
}