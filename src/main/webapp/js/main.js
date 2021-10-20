// 엘리먼트 획득
function getEl(id) {
    if(document.all) return document.all(id);
    if(document.getElementById) return document.getElementById(id);
}

// GET 파라미터 가져오기 - 없으면 '' 회신
function getParam(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
    var results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}