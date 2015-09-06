// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function showDummyBracket() {
    var el = document.getElementById("numseeds")
    var idx = el.selectedIndex;
    var str = el.options[idx].text;
//	var blotz = 0 / 0;
//    document.getElementById("dummybracketdisplay").value = str;
//  document.getElementById("numseeds").parentNode.submit();
//  this.parentNode.submit();
  document.getElementById("dummybracketdisplay").innerHTML = " Hello " + recurse(Number(str)) +
	document.getElementById("dummybracketdisplay").innerHTML;
}

