fl.createDocument();
var document = fl.getDocumentDOM();
var library = document.library;
var fileMask = "*.jpg";

var path = FLfile.platformPathToURI("E:\\李冰\\12201\\data\\thumb\\");

var list = FLfile.listFolder(path + fileMask, "files");

for(var i=0; i<list.length; i++) {
	document.importFile(path + list[i], true);
}
for(var i=0; i<library.items.length; i++) {
	library.items[i].linkageExportForAS = true;
	library.items[i].linkageExportInFirstFrame = true;
	library.items[i].linkageBaseClass = "flash.display.BitmapData";
	library.items[i].compressionType="photo";
    library.items[i].quality = 50;
	library.items[i].linkageClassName = "M" + library.items[i].name.split(".")[0];
	library.items[i].linkageExportForRS = false;
}
