/* generated by rust_qt_binding_generator */
#include "Bindings.h"

namespace {

    struct option_quintptr {
    public:
        quintptr value;
        bool some;
        operator QVariant() const {
            if (some) {
                return QVariant(value);
            }
            return QVariant();
        }
    };

    struct qstring_t {
    private:
        const void* data;
        int len;
    public:
        qstring_t(const QString& v):
            data(static_cast<const void*>(v.utf16())),
            len(v.size()) {
        }
        operator QString() const {
            return QString::fromUtf8(static_cast<const char*>(data), len);
        }
    };
    typedef void (*qstring_set)(QString*, qstring_t*);
    void set_qstring(QString* v, qstring_t* val) {
        *v = *val;
    }

    struct qmodelindex_t {
        int row;
        quintptr id;
    };
}
extern "C" {
    void todo_data_title(const Todo::Private*, int, QString*, qstring_set);
    bool todo_set_data_title(Todo::Private*, int, qstring_t);
    void todo_sort(Todo::Private*, unsigned char column, Qt::SortOrder order = Qt::AscendingOrder);

    int todo_row_count(const Todo::Private*);
    bool todo_can_fetch_more(const Todo::Private*);
    void todo_fetch_more(Todo::Private*);
}
int Todo::columnCount(const QModelIndex &parent) const
{
    return (parent.isValid()) ? 0 : 1;
}

bool Todo::hasChildren(const QModelIndex &parent) const
{
    return rowCount(parent) > 0;
}

int Todo::rowCount(const QModelIndex &parent) const
{
    return (parent.isValid()) ? 0 : todo_row_count(m_d);
}

QModelIndex Todo::index(int row, int column, const QModelIndex &parent) const
{
    if (!parent.isValid() && row >= 0 && row < rowCount(parent) && column >= 0 && column < 1) {
        return createIndex(row, column, (quintptr)row);
    }
    return QModelIndex();
}

QModelIndex Todo::parent(const QModelIndex &) const
{
    return QModelIndex();
}

bool Todo::canFetchMore(const QModelIndex &parent) const
{
    return (parent.isValid()) ? 0 : todo_can_fetch_more(m_d);
}

void Todo::fetchMore(const QModelIndex &parent)
{
    if (!parent.isValid()) {
        todo_fetch_more(m_d);
    }
}

void Todo::sort(int column, Qt::SortOrder order)
{
    todo_sort(m_d, column, order);
}
Qt::ItemFlags Todo::flags(const QModelIndex &i) const
{
    auto flags = QAbstractItemModel::flags(i);
    if (i.column() == 0) {
        flags |= Qt::ItemIsEditable;
    }
    return flags;
}

QVariant Todo::title(int row) const
{
    QVariant v;
    QString s;
    todo_data_title(m_d, row, &s, set_qstring);
    if (!s.isNull()) v.setValue<QString>(s);
    return v;
}

bool Todo::setTitle(int row, const QVariant& value)
{
    bool set = false;
    set = todo_set_data_title(m_d, row, value.value<QString>());
    if (set) {
        QModelIndex index = createIndex(row, 0, row);
        emit dataChanged(index, index);
    }
    return set;
}

QVariant Todo::data(const QModelIndex &index, int role) const
{
    Q_ASSERT(rowCount(index.parent()) > index.row());
    switch (index.column()) {
    case 0:
        switch (role) {
        case Qt::DisplayRole:
        case Qt::EditRole:
        case Qt::UserRole + 0:
            return title(index.row());
        }
    }
    return QVariant();
}

QHash<int, QByteArray> Todo::roleNames() const {
    QHash<int, QByteArray> names = QAbstractItemModel::roleNames();
    names.insert(Qt::UserRole + 0, "title");
    return names;
}
QVariant Todo::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation != Qt::Horizontal) {
        return QVariant();
    }
    return m_headerData.value(qMakePair(section, (Qt::ItemDataRole)role), role == Qt::DisplayRole ?QString::number(section + 1) :QVariant());
}

bool Todo::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (orientation != Qt::Horizontal) {
        return false;
    }
    m_headerData.insert(qMakePair(section, (Qt::ItemDataRole)role), value);
    return true;
}

bool Todo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (index.column() == 0) {
        if (role == Qt::DisplayRole || role == Qt::EditRole || role == Qt::UserRole + 0) {
            return setTitle(index.row(), value);
        }
    }
    return false;
}

extern "C" {
    Todo::Private* todo_new(Todo*,
        void (*)(const Todo*),
        void (*)(Todo*, quintptr, quintptr),
        void (*)(Todo*),
        void (*)(Todo*),
        void (*)(Todo*, int, int),
        void (*)(Todo*),
        void (*)(Todo*, int, int),
        void (*)(Todo*));
    void todo_free(Todo::Private*);
};

Todo::Todo(bool /*owned*/, QObject *parent):
    QAbstractItemModel(parent),
    m_d(0),
    m_ownsPrivate(false)
{
    initHeaderData();
}

Todo::Todo(QObject *parent):
    QAbstractItemModel(parent),
    m_d(todo_new(this,
        [](const Todo* o) {
            emit o->newDataReady(QModelIndex());
        },
        [](Todo* o, quintptr first, quintptr last) {
            o->dataChanged(o->createIndex(first, 0, first),
                       o->createIndex(last, 0, last));
        },
        [](Todo* o) {
            o->beginResetModel();
        },
        [](Todo* o) {
            o->endResetModel();
        },
        [](Todo* o, int first, int last) {
            o->beginInsertRows(QModelIndex(), first, last);
        },
        [](Todo* o) {
            o->endInsertRows();
        },
        [](Todo* o, int first, int last) {
            o->beginRemoveRows(QModelIndex(), first, last);
        },
        [](Todo* o) {
            o->endRemoveRows();
        }
)),
    m_ownsPrivate(true)
{
    connect(this, &Todo::newDataReady, this, [this](const QModelIndex& i) {
        this->fetchMore(i);
    }, Qt::QueuedConnection);
    initHeaderData();
}

Todo::~Todo() {
    if (m_ownsPrivate) {
        todo_free(m_d);
    }
}
void Todo::initHeaderData() {
    m_headerData.insert(qMakePair(0, Qt::DisplayRole), QVariant("title"));
}
