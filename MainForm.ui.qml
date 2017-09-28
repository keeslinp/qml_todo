import QtQuick 2.6
import RustCode 1.0

Rectangle {
    property alias mouseArea: mouseArea
    property alias rust: rust

    Todo {
        id: rust
    }

    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
    ListView {
        id: view
        anchors.fill: parent
        model: Todo {}
        delegate: Text {
            // use the defined model role "display"
            text: 'tacos'
        }
    }

    // TextEdit {
        // id: textEdit
        // text: rust.message
        // verticalAlignment: Text.AlignVCenter
        // anchors.top: parent.top
        // anchors.horizontalCenter: parent.horizontalCenter
        // anchors.topMargin: 20
        // Rectangle {
            // anchors.fill: parent
            // anchors.margins: -10
            // color: "transparent"
            // border.width: 1
        // }
    // }
}
