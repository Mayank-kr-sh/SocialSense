const mongoose = require("mongoose");
const { ObjectId } = mongoose.Types;
const User = require("../models/UserModel");
const Post = require("../models/PostModel");
const Like = require("../models/LikeModel");

exports.like = async (req, res) => {
  try {
    const postId = req.params.postId;
    const { userId } = req.body;

    if (!postId)
      return res
        .status(400)
        .json({ msg: "PostId is required", success: false });

    if (!userId)
      return res
        .status(400)
        .json({ msg: "UserId is required", success: false });

    const post = await Post.findById(postId);

    if (!post)
      return res.status(404).json({ msg: "Post not found", success: false });

    const user = await User.findById(userId);

    if (!user)
      return res.status(404).json({ msg: "User not found", success: false });

    const isLiked = post.likes.includes(userId);

    // check if liked post exist in the database
    const existingLike = await Like.findOne({ user: userId, post: postId });

    if (isLiked) {
      // If the post is already liked, remove the like
      post.likes = post.likes.filter((like) => like.toString() !== userId);
      // remove the like from the post
      post.likes.pop(userId);
      await post.save();
      // remove the like from the database
      await Like.deleteOne({ _id: existingLike._id });
      return res.status(200).json({
        success: true,
        message: "Post unliked successfully",
        post,
      });
    } else {
      // If the post is not liked yet, add a like
      const newLike = new Like({ user: userId, post: postId });
      await newLike.save();
      post.likes.push(userId);
      await post.save();
      return res.status(200).json({
        success: true,
        message: "Post liked successfully",
        post,
      });
    }
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error In Liking" });
  }
};
