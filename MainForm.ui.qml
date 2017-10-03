import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import RustCode 1.0

ColumnLayout {


    // MouseArea {
        // id: mouseArea
        // anchors.fill: parent
    // }
    // anchors.horizontalCenter: parent.horizontalCenter

    anchors.fill: parent
    // // TextEdit {
        // // id: textEdit
        // // text: rust.message
        // // Rectangle {
            // // anchors.fill: parent
            // // anchors.margins: -10
            // // color: "transparent"
            // // border.width: 1
        // // }
    // // }
    Todo {
        id: rust
    }
    ListView {
        property alias rust: rust

        id: view
        anchors.top: parent.top
        anchors.right: parent.horizontalCenter
        anchors.left: parent.left
        anchors.bottom: parent.verticalCenter
        model: rust.tasks
        delegate: RowLayout {
            anchors.right: parent.horizontalCenter
            Text {
                font.strikeout: model.completed
                text: model.title
            }
            CheckBox {
                // anchors.right: parent.right
                onClicked: model.completed = !model.completed
            }
        }
    }
    RowLayout {
        anchors.top: parent.verticalCenter
        anchors.left: parent.left
        TextEdit {
            text: rust.val
            id: textEdit
        }
        Button {
            text: 'Submit'
            onClicked: {
                var count = rust.tasks.rowCount();
                rust.tasks.insertRows(count, 1);
                rust.tasks.setTitle(count, textEdit.text);
            }
        }
        Button {
            text: 'Sweep Completed'
            onClicked: {
                var count = rust.tasks.rowCount();
                for(var i = 0; i < count; i++) {
                    if (rust.tasks.completed(i)) {
                        rust.tasks.removeRows(i, 1);
                        i--;
                        count--;
                    }
                }
            }
        }
    }
}
