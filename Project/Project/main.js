





function load() {

    var t = Box.template();
    
    var i = t.create();
        i.rotation = {"AXIS": [0.2, 0.3, 0.2], "angle":pi};
        i.position = {"Point": [0, 1, -2]};
    
    var j = t.create();
        j.rotation = {"AXIS": [0.1, 0.3, 0.2], "angle":pi};
        j.position = [0, -1, -2];
}