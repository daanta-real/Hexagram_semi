// 엘리먼트 획득
var getEl = (id) => document.getElementById(id);

// GET 파라미터 가져오기 - 없으면 '' 회신
function getParam(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
    var results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// Hacks for prevent whitespace for wholescreen elements 


// 디버그용 - 랜덤한 css html 보더 설정
function rainbow(query, styles) {
    var rndClr = ['Red', 'Lime', 'Blue', 'Yellow', 'Cyan', 'Magenta', 'Silver', 'Gray', 'Maroon', 'Olive', 'Green', 'Purple', 'Teal', 'Navy'];
    document.querySelectorAll(query).forEach((el) => {
        var rnd = Math.floor(Math.random() * rndClr.length);
        var clr = rndClr[rnd];
        el.style.border = '1px solid ' + clr;
        if(styles != undefined) for(var i in styles) el.style[i] = styles[i];
    });
}
const debug_rainbowQueryRun = () => {
	const query = document.getElementById("debug_query").value;
	console.log('"' + query + '"의 쿼리에 해당하는 레이어 레인보우화 실행됨');
	rainbow(query, { padding:"0.3rem", margin:"0.2rem" });
};

/*
document.getElementById("mobileMenuContainer").addEventListener("onload", () => {
	this.style.tranform = "translateX(-80vw)";
});*/