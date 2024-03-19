const express = require("express");
const User = require("../models/UserModel");
const Post = require("../models/PostModel");
const Likes = require("../models/LikeModel");
const Comments = require("../models/CommentsModel");

exports.fetchPosts = async (req, res) => {
  try {
    const posts = await Post.find()
      .populate("user", "userName profilepic")
      .populate("likes", "user")
      .populate({
        path: "comments",
        populate: { path: "user", select: "userName" },
      });

    const postsWithDetails = await Promise.all(
      posts.map(async (post) => {
        const totalLikes = await Likes.countDocuments({ post: post._id });
        const totalComments = await Comments.countDocuments({ post: post._id });

        const likesDetails = await Likes.find({ post: post._id }).populate(
          "user",
          "userName"
        );
        const commentsDetails = await Comments.find({
          post: post._id,
        }).populate("user", "userName");

        return {
          _id: post._id,
          user: post.user,
          comments: post.comments,
          likes: post.likes,
          caption: post.caption,
          media: post.media,
          createdAt: post.createdAt,
          totalLikes,
          totalComments,
          likesDetails,
          commentsDetails,
        };
      })
    );

    return res.status(200).json({
      success: true,
      posts: postsWithDetails,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error In Fetching Post" });
  }
};
