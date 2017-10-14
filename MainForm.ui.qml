import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import RustCode 1.0

ColumnLayout {


    anchors.fill: parent
    Tasks {
        id: rust
    }
    Rectangle {
        border.width: 2
        Layout.fillWidth: true
        Layout.leftMargin: 25 
        Layout.rightMargin: 25
        Layout.preferredHeight: parent.height * 0.8
        ListView {
            anchors.fill: parent
            anchors.margins: 50
            property alias rust: rust
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
            delegate:
                Rectangle {
                    id: rectangleContainer
                    states: [
                        State {
                            name: "complete"
                            PropertyChanges { target: rectangleContainer; color: "lightgrey" }
                            PropertyChanges { target: taskTitle; font.strikeout: true }
                            when: model.completed
                        }
                    ]
                    transitions: Transition {
                        ColorAnimation { duration: 1000; easing.type: Easing.OutExpo }
                    }
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 40 

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 25
                        anchors.rightMargin: 25
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                model.completed = !model.completed;
                            }
                            Text {
                                id: taskTitle 
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                font.pointSize: 15
                                text: model.title
                            }
                            CheckBox {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                checked: model.completed
                            }
                        }
                    }
                }
        }
    }
    Rectangle {
        Layout.preferredHeight: parent.height * 0.1
        Layout.fillWidth: true
        color: "grey"
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 50
            anchors.rightMargin: 50
            spacing: 20
            TextField {
                Layout.fillWidth: true
                placeholderText: "Add a Task"
                id: newTask 
            }
            Button {
                text: 'Submit'
                onClicked: {
                    const text = newTask.text;
                    if (text) {
                        var count = rust.rowCount();
                        rust.insertRows(count, 1);
                        rust.setTitle(count, text);
                        newTask.text = "";
                    }
                }
            }
            Button {
                text: 'Sweep Completed'
                onClicked: {
                    rust.sweep();
                }
            }
        }
    }
}
