

function load() {
    parser.parseFile("scene.fmt");

    loadStandardLights();

    triggerManager.addActionForTrigger(trackballPan, {"gesture": "pan"});
}

