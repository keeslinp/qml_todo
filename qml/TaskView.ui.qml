import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    function toggleCompleted() {
        model.completed = !model.completed;
    }
    id: rectangleContainer
    signal edit()
    anchors.fill: parent
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
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 25
        anchors.rightMargin: 25
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: toggleCompleted()
            Text {
                id: taskTitle 
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pointSize: 15
                text: model.title
            }
            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                Button {
                    id: editButton
                    flat: true
                    text: "edit"
                    onClicked: rectangleContainer.edit()
                }
                CheckBox {
                    id: checkbox
                    checked: model.completed
                    onToggled: toggleCompleted()
                }
            }
        }
    }
}
