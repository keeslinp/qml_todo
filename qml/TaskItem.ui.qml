import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    anchors.left: parent.left
    anchors.right: parent.right
    height: 40 
    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: 0
        TaskView {
            onEdit: stack.currentIndex = 1
        }
        TaskEdit {
            onSave: {
                model.title = value;
                stack.currentIndex = 0;
            }
            onCancel: stack.currentIndex = 0
        }
    }
}
