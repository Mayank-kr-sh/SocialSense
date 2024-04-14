const express = require("express");
const User = require("../models/UserModel");
const Post = require("../models/PostModel");
const Likes = require("../models/LikeModel");
const Comments = require("../models/CommentsModel");

exports.fetchPosts = async (req, res) => {
  try {
    const posts = await Post.find()
      .populate("user", "name")
      .populate({
        path: "comments",
        populate: { path: "user", select: "name" },
      });

    const postsWithDetails = await Promise.all(
      posts.map(async (post) => {
        const totalLikes = await Likes.countDocuments({ post: post._id });
        const totalComments = await Comments.countDocuments({ post: post._id });

        return {
          _id: post._id,
          user: post.user,
          comments: post.comments,
          caption: post.caption,
          media: post.media,
          createdAt: post.createdAt,
          totalLikes,
          totalComments,
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

exports.fetchUserPosts = async (req, res) => {
  const { userId } = req.params;
  try {
    const posts = await Post.find({ user: userId })
      .populate("user", "name")
      .populate({
        path: "comments",
        populate: { path: "user", select: "name" },
      });

    const postsWithDetails = await Promise.all(
      posts.map(async (post) => {
        const totalLikes = await Likes.countDocuments({ post: post._id });
        const totalComments = await Comments.countDocuments({ post: post._id });

        return {
          _id: post._id,
          user: post.user,
          comments: post.comments,
          caption: post.caption,
          media: post.media,
          createdAt: post.createdAt,
          totalLikes,
          totalComments,
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

exports.fetchUserComments = async (req, res) => {
  const { userId } = req.params;
  try {
    const comments = await Comments.find({ user: userId })
      .populate({
        path: "post",
        select: "caption media",
        populate: { path: "user", select: "name" },
      })
      .populate("user", "name");

    return res.status(200).json({
      success: true,
      comments: comments.map((comment) => ({
        _id: comment._id,
        post: comment.post,
        user: comment.user,
        text: comment.text,
        createdAt: comment.createdAt,
      })),
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error in fetching comments" });
  }
};
