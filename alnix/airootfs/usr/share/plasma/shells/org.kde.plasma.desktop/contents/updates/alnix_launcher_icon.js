// Use the Alnix logo for the application launcher button

const launchers = [
    "org.kde.plasma.kickoff",
    "org.kde.plasma.kicker",
    "org.kde.plasma.kickerdash",
];

const containments = desktops().concat(panels());
for (var i in containments) {
    const widgets = containments[i].widgets();
    for (var j in widgets) {
        const widget = widgets[j];
        if (launchers.indexOf(widget.type) !== -1) {
            widget.currentConfigGroup = new Array("General");
            widget.writeConfig("icon", "alnix-logo");
        }
    }
}
