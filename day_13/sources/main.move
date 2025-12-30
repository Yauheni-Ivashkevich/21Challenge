/// DAY 13: Simple Aggregations (Total Reward, Completed Count)
/// 
/// Today (Done in main.move):
/// 1. Wrote functions that iterate over vectors
/// 2. Calculated totals and counts
/// 3. Practiced with control flow


module challenge::day_13 {
    use std::string::String;


    // Copy from day_12: All structs and functions
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


    // TODO: Write a function 'total_reward' that:
    // - Takes board: &TaskBoard  // - Returns u64 (sum of all task rewards)
    // - Loops through all tasks and sums their rewards
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


    // TODO: Write a function 'completed_count' that:
    // - Takes board: &TaskBoard | // - Returns u64 (count of completed tasks)
    // - Loops through tasks and counts those with status == Completed
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

