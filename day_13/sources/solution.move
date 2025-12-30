/// DAY 13: Simple Aggregations - SOLUTION
/// 
/// This is the solution file for day 13.
/// Students should complete main.move, not this file.

module challenge::day_13_solution {
    use std::string::String;

    // Copy TaskBoard and related structs from previous days
    public enum TaskStatus has copy, drop {
        Open,
        Completed,
    }

    public struct Task has copy, drop {
        title: String,
        reward: u64,
        status: TaskStatus,
    }

    public struct TaskBoard has drop {
        owner: address,
        tasks: vector<Task>,
    }

    public fun new_task(title: String, reward: u64): Task {
        Task {
            title,
            reward,
            status: TaskStatus::Open,
        }
    }

    public fun new_board(owner: address): TaskBoard {
        TaskBoard {
            owner,
            tasks: vector::empty(),
        }
    }

    public fun add_task(board: &mut TaskBoard, task: Task) {
        vector::push_back(&mut board.tasks, task);
    }

    public fun complete_task(task: &mut Task) {
        task.status = TaskStatus::Completed;
    }

    // Calculate total reward of all tasks
    public fun total_reward(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut total = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            total = total + task.reward;
            i = i + 1;
        };
        total
    }

    // Count completed tasks
    public fun completed_count(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut count = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            if (task.status == TaskStatus::Completed) {
                count = count + 1;
            };
            i = i + 1;
        };
        count
    }
}

