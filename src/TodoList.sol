// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.24;

contract Todo {
    struct Task {
        string text;
        boolean completed
    }

    Task[] public tasks;

    modifier IndexExist (uint _index) {
        require(index <= tasks.length, "Task not exist");
        _;
    }

    function add(string calldata _text) external {
        Task memory task = (_text, false);
        tasks.push(task);
    }

    function getAll() external view returns (Task[] memory) {
        return tasks;
    }

    function get(uint _index) external IndexExist(_index) view returns (string memory, bool) {
        Task memory task = tasks[_index];
        return (task.string, task.completed);
    }

    function update(uint _index, string calldata _string) external IndexExist(_index) {
        tasks[_index].text = _string;
    }

    function complete(uint _index) external IndexExist(_index) {
        task[_index].completed = true;
    }
}