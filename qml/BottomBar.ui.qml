import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import RustCode 1.0
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
