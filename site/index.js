const terminalOnlySizes = [0, 100];
const editorOnlySizes = [100, 0];
const bothSizes = [75, 25];
const neitherSizes = [0, 0];

var editorCollapsed = false;
var terminalCollapsed = false;

var split = Split(['#editor', '#terminal'], {
	sizes: bothSizes
});

function toggleEditor() {
	editorCollapsed = !editorCollapsed;
	updateSplit();
}

function toggleTerminal() {
	terminalCollapsed = !terminalCollapsed;
	updateSplit();
}

function updateSplit() {
	if (terminalCollapsed && editorCollapsed) {
		split.setSizes(neitherSizes);
	} else if (terminalCollapsed && !editorCollapsed) {
		split.setSizes(editorOnlySizes);
	} else if (!terminalCollapsed && editorCollapsed) {
		split.setSizes(terminalOnlySizes);
	} else {
		split.setSizes(bothSizes);
	}
}
