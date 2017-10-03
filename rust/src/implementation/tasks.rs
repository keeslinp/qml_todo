use interface::*;

#[derive(Default, Clone, Debug)]
pub struct TasksItem {
    title: String,
    completed: bool,
}

impl TasksItem {
    pub fn new(title: String) -> TasksItem {
        TasksItem {
            title,
            completed: false,
        }
    }
}
pub struct Tasks {
    emit: TasksEmitter,
    model: TasksList,
    list: Vec<TasksItem>,
}

impl Tasks {
    pub fn append(&mut self, value: String) {
        self.list[0].title.push_str("blarg");
        self.list.push(TasksItem::new(value));
        self.emit.new_data_ready();
    }
}

impl TasksTrait for Tasks {
    fn new(emit: TasksEmitter, model: TasksList) -> Tasks {
        Tasks {
            emit: emit,
            model: model,
            list: vec!["test", "test2"].iter().map(|&val| TasksItem::new(String::from(val))).collect(),
        }
    }
    fn emit(&self) -> &TasksEmitter {
        &self.emit
    }
    fn row_count(&self) -> usize {
        self.list.len()
    }
    fn title(&self, item: usize) -> &str {
        &self.list[item].title
    }
    fn set_title(&mut self, item: usize, v: String) -> bool {
        self.list[item].title = v;
        true
    }

    fn completed(&self, item: usize) -> bool {
        self.list[item].completed
    }

    fn set_completed(&mut self, item: usize, v: bool) -> bool {
        self.list[item].completed = v;
        true
    }

    fn insert_rows(&mut self, row: usize, count: usize) -> bool {
        self.model.begin_insert_rows(row, row + count - 1);
        self.list.push(TasksItem::default());
        self.model.end_insert_rows();
        true
    }

    fn remove_rows(&mut self, row: usize, count: usize) -> bool{
        self.model.begin_remove_rows(row, row + count - 1);
        self.list.drain((row)..(row + count));
        self.model.end_remove_rows();
        true
    }
}

