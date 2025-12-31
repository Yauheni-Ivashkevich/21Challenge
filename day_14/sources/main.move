/// DAY 14: Tests for Bounty Board
/// 
/// Today (Done in main.move):
/// 1. Wrote comprehensive tests
/// 2. Tested all the functions you've created
/// 3. Practiced test organization


module challenge::day_14 {
    use std::string::String;


    #[test_only]
    use std::unit_test::assert_eq;
    use std::string;

    // Copy from day_13: All structs and functions
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

    // Note: assert! is a built-in macro in Move 2024 - no import needed!
    // TODO: Write at least 3 tests:
    // 
    // Test 1: test_create_board_and_add_task // - Create a board with an owner | // - Add a task
    // - Verify the task was added
    #[test]
    fun test_create_board_and_add_task() {
        let owner = @0x1;
        let mut board = new_board(owner);
        
        let task = new_task(string::utf8(b"Fix bug"), 100);
        add_task(&mut board, task);
        
        let len = vector::length(&board.tasks);
        assert_eq!(len, 1);
    }

    // Test 2: test_complete_task // - Create board, add tasks | // - Complete a task
    // - Verify completed_count is correct
    #[test]
    fun test_complete_task() {
        let owner = @0x1;
        let mut board = new_board(owner);
        
        let task1 = new_task(string::utf8(b"Task 1"), 50);
        let task2 = new_task(string::utf8(b"Task 2"), 100);
        
        add_task(&mut board, task1);
        add_task(&mut board, task2);
        
        // Complete first task
        let task = vector::borrow_mut(&mut board.tasks, 0);
        complete_task(task);
        
        assert_eq!(completed_count(&board), 1);
    }


    // Test 3: test_total_reward // - Create board, add multiple tasks with different rewards
    // - Verify total_reward is correct.    
     #[test]
    fun test_total_reward() {
        let owner = @0x1;
        let mut board = new_board(owner);
        
        let task1 = new_task(string::utf8(b"Task 1"), 50);
        let task2 = new_task(string::utf8(b"Task 2"), 100);
        let task3 = new_task(string::utf8(b"Task 3"), 25);
        
        add_task(&mut board, task1);
        add_task(&mut board, task2);
        add_task(&mut board, task3);
        
        let total = total_reward(&board);
        assert_eq!(total, 175);
    }
}

