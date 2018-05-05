const terminalOnlySizes = [0, 100];
const editorOnlySizes = [100, 0];
const bothSizes = [75, 25];
const neitherSizes = [0, 0];

const sizeMap = {
  "false,false,false" : [0, 0, 0],
  "false,false,true" : [0, 0, 100],
  "false,true,false" : [0, 100, 0],
  "false,true,true" : [0, 75, 25],
  "true,false,false" : [100, 0, 0],
  "true,false,true" : [50, 0, 50],
  "true,true,false" : [50, 50, 0],
  "true,true,true" : [30, 50, 20],
}

var docsVisible = true;
var editorVisible = true;
var terminalVisible = true;

var split = Split(['#docs', '#editor', '#terminal'], {
	sizes: sizeMap[[docsVisible, editorVisible, terminalVisible].toString()]
});

function toggleEditor() {
	editorVisible = !editorVisible;
	updateSplit();
}

function toggleTerminal() {
	terminalVisible = !terminalVisible;
	updateSplit();
}

function toggleDocs() {
	docsVisible = !docsVisible;
	updateSplit();
}

function updateSplit() {
	var sizes = sizeMap[[docsVisible, editorVisible, terminalVisible].toString()];
	split.setSizes(sizes);
}
