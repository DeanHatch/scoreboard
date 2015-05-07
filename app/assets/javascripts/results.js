// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function updateScoreFieldsForCorrecting() {
    var el = document.getElementById("fixcontest_id")
    var idx = el.selectedIndex;
    var str = el.options[idx].text;
    var patt = new RegExp(/\d+ - \d+/);
    var res = patt.exec(str);
    var nnpatt = new RegExp(/\d+/g);
    var aw = nnpatt.exec(res);
    var hm = nnpatt.exec(res);
    document.getElementById("fixhomescore").value = hm;
    document.getElementById("fixawayscore").value = aw;
}