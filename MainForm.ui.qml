import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import RustCode 1.0

ColumnLayout {


    anchors.fill: parent
    Tasks {
        id: rust
    }
    ListView {
        property alias rust: rust

        id: view
        anchors.top: parent.top
        anchors.right: parent.horizontalCenter
        anchors.left: parent.left
        anchors.bottom: parent.verticalCenter
        model: rust
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
            text: "New Task"
            id: textEdit
        }
        Button {
            text: 'Submit'
            onClicked: {
                var count = rust.rowCount();
                rust.insertRows(count, 1);
                rust.setTitle(count, textEdit.text);
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
