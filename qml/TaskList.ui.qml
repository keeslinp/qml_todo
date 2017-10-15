import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import RustCode 1.0

Rectangle {
    border.width: 2
    Layout.fillWidth: true
    Layout.leftMargin: 25 
    Layout.rightMargin: 25
    Layout.preferredHeight: parent.height * 0.8
    ListView {
        anchors.fill: parent
        anchors.margins: 50
        remove: Transition {
            id: dispTrans
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 500; easing.type: Easing.InExpo }
                NumberAnimation {
                    property: "y"; to: 0
                    duration: 500 
                    easing.type: Easing.InExpo
                }
            }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.InExpo }
        }
        id: view
        model: rust
        delegate: TaskItem { }
    }
}
