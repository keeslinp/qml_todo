import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import RustCode 1.0

ColumnLayout {


    anchors.fill: parent
    Tasks {
        id: rust
    }
    TaskList {
        property alias rust: rust
    }
    BottomBar {
        property alias rust: rust
    }
}
