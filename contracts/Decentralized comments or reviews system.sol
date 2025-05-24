// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedComments {
    struct Comment {
        address commenter;
        string content;
        uint256 timestamp;
    }

    // Mapping: item ID (e.g., product, post) => array of comments
    mapping(bytes32 => Comment[]) private comments;

    event CommentAdded(bytes32 indexed itemId, address indexed commenter, string content, uint256 timestamp);

    // Add a comment for a specific item identified by itemId
    function addComment(bytes32 itemId, string calldata content) external {
        require(bytes(content).length > 0, "Comment content cannot be empty");

        comments[itemId].push(Comment({
            commenter: msg.sender,
            content: content,
            timestamp: block.timestamp
        }));

        emit CommentAdded(itemId, msg.sender, content, block.timestamp);
    }

    // Get the number of comments for an item
    function getCommentCount(bytes32 itemId) external view returns (uint256) {
        return comments[itemId].length;
    }

    // Get a comment by index for an item
    function getComment(bytes32 itemId, uint256 index) external view returns (address commenter, string memory content, uint256 timestamp) {
        require(index < comments[itemId].length, "Comment index out of bounds");
        Comment memory comment = comments[itemId][index];
        return (comment.commenter, comment.content, comment.timestamp);
    }
}
