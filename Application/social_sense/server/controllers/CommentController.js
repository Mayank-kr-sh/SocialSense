const mongoose = require("mongoose");
const user = require("../models/UserModel");
const post = require("../models/PostModel");
const comment = require("../models/CommentsModel");

exports.comment = async (req, res) => {
  try {
    const postId = req.params.postId;
    const { userId, text } = req.body;

    console.log("userId", text);
    if (!postId) {
      return res.status(400).json({ msg: "PostId is required" });
    }

    if (!userId) {
      return res.status(400).json({ msg: "UserId is required" });
    }

    if (!text) {
      return res.status(400).json({ msg: "Text is required" });
    }

    console.log("PostId", postId);
    console.log("UserId", userId);
    console.log("Text", text);

    const Post = await post.findById(postId);

    if (!Post) {
      return res.status(404).json({ msg: "Post not found", success: false });
    }

    const userObj = userId ? new mongoose.Types.ObjectId(userId) : null;

    const newComment = new comment({
      user: userObj,
      post: postId,
      text: text,
    });

    await newComment.save();
    if (!Post.comments || !Array.isArray(Post.comments)) {
      Post.comments = [];
    }

    Post.comments.push(newComment);
    await Post.save(); // Save the updated post

    if (userId) {
      await user.findByIdAndUpdate(userId, { $push: { comments: newComment } });
    }

    return res
      .status(201)
      .json({ msg: "Comment Added", success: true, data: newComment });
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error In Commenting" });
  }
};

exports.deleteComment = async (req, res) => {
  const { commentId } = req.params;

  if (!commentId) {
    return res.status(400).json({ msg: "CommentId is required" });
  }

  try {
    const Comment = await comment.findById(commentId);

    if (!Comment) {
      return res.status(404).json({ msg: "Comment not found", success: false });
    }

    await comment.findByIdAndDelete(commentId);

    const postUpdated = await post.findByIdAndUpdate(
      Comment.post,
      {
        $pull: { comments: commentId },
      },
      { new: true }
    );
    if (Comment.user) {
      await user.findByIdAndUpdate(Comment.user, {
        $pull: { comments: commentId },
      });
    }
    return res
      .status(200)
      .json({ msg: "Comment deleted successfully", postUpdated });
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error In Deleting Comment" });
  }
};
