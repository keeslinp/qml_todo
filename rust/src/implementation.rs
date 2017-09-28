use interface::*;

#[derive(Default, Clone)]
pub struct TodoItem {
    title: String,
}
pub struct Todo {
    emit: TodoEmitter,
    model: TodoList,
    list: Vec<TodoItem>,
}

impl TodoTrait for Todo {
    fn new(emit: TodoEmitter, model: TodoList) -> Todo {
        Todo {
            emit: emit,
            model: model,
            list: vec![TodoItem::default(); 10],
        }
    }
    fn emit(&self) -> &TodoEmitter {
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
}

