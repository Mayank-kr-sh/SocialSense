const express = require("express");
const cloudinary = require("cloudinary").v2;
const User = require("../models/UserModel");
const Post = require("../models/PostModel");

const app = express();

async function uploadFilesToCloudinary(file, folder) {
  const options = { folder };
  options.resource_type = "auto";
  return await cloudinary.uploader.upload(file.tempFilePath, options);
}

exports.upload = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ msg: "User not found", success: false });
    }

    const { caption } = req.body;
    // const files = req.files ? req.files.imageFile : [];
    let files = [];

    if (req.files) {
      if (Array.isArray(req.files.imageFile)) {
        files = req.files.imageFile;
      } else {
        files.push(req.files.imageFile);
      }
    }

    const supportedTypes = ["jpg", "jpeg", "png"];

    const media = [];

    if (files.length === 0 && !caption) {
      // If no files and no caption, return an error
      return res.status(400).json({
        message: "Please provide at least an image or caption",
        success: false,
      });
    }

    for (const file of files) {
      const fileType = file.name.split(".").pop().toLowerCase();

      if (!supportedTypes.includes(fileType)) {
        return res
          .status(400)
          .json({ message: "File Type Not Supported", success: false });
      }

      const uploadedFile = await uploadFilesToCloudinary(file, "SocialSense");
      media.push(uploadedFile.secure_url);
    }

    const newPost = new Post({
      user: userId,
      media: media,
      caption,
    });

    await newPost.save();

    res.status(200).json({
      message: "File Uploaded Successfully",
      data: newPost,
      success: true,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ msg: "Server error In uploading post" });
  }
};
