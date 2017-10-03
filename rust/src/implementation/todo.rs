use implementation::tasks::Tasks;
use interface::*;

pub struct Todo {
    emit: TodoEmitter,
    val: String,
    tasks: Tasks,
}

impl TodoTrait for Todo {
    fn new(emit: TodoEmitter, tasks: Tasks) -> Todo {
        Todo {
            emit: emit,
            val: String::from("tacos sauce"),
            tasks,
        }
    }
    fn emit(&self) -> &TodoEmitter {
        &self.emit
    }

    fn tasks(&self) -> &Tasks {
        &self.tasks
    }

    fn tasks_mut(&mut self) -> &mut Tasks {
        &mut self.tasks
    }

    fn val(&self) -> &str {
        &self.val
    }

    fn set_val(&mut self, value : String) {
        println!("Adding {}", value);
        self.tasks.append(value);
    }
}

