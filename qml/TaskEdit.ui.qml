import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    id: rectangleContainer
    signal save(string value)
    signal cancel()
    anchors.fill: parent
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 25
        anchors.rightMargin: 25
        TextField {
            id: editTitle
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pointSize: 15
            text: model.title
        }
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            Button {
                text: "save"
                onClicked: rectangleContainer.save(editTitle.text)
            }
            Button {
                text: "cancel"
                onClicked: {
                    editTitle.text = model.title;
                    rectangleContainer.cancel();
                }
            }
        }
    }
}
