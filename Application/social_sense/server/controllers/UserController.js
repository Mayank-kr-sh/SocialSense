const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require("../models/UserModel");

const app = express();

exports.register = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    let user = await User.findOne({ email });

    if (user) {
      return res.status(400).json({
        success: false,
        message: "User already exists",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const Newuser = await User.create({
      name,
      email,
      password: hashedPassword,
    });

    return res.status(201).json({
      success: true,
      message: "User registered successfully",
      data: Newuser,
    });
  } catch (err) {
    console.error(err.message);
    return res.status(400).json({
      success: false,
      message: `User cannot be registered. Please try again later.${err.message}`,
    });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;
  try {
    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Please provide email and password",
      });
    }

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({
        success: false,
        message: "User not found",
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({
        success: false,
        message: "Invalid credentials",
      });
    }

    const payload = {
      user: {
        id: user.id,
        email: user.email,
      },
    };
    const { password: userPassword, __v, ...userData } = user.toObject();
    const token = jwt.sign(payload, "Mayank", {
      expiresIn: 3600,
    });

    return res.status(200).json({
      success: true,
      message: "User logged in successfully",
      user: userData,
      token,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Login Server Error", err.message);
  }
};

exports.update = async (req, res) => {
  const { id, ...updateFields } = req.body;
  try {
    const user = await User.findById(id);

    if (!user) {
      return res.status(400).json({
        success: false,
        message: "User not found",
      });
    }

    let updateObject = {};
    for (let field in updateFields) {
      if (updateFields[field] !== undefined) {
        updateObject[field] = updateFields[field];
      }
    }

    const updated = await User.findByIdAndUpdate(id, updateObject, {
      new: true,
      runValidators: true,
    });

    return res.status(200).json({
      success: true,
      message: "User updated successfully",
      data: updated,
    });
  } catch (err) {
    console.error(err.message);
    return res.status(400).json({
      success: false,
      message: "User cannot be updated. Please try again later.",
    });
  }
};

exports.searchUser = async (req, res) => {
  const { name } = req.query;
  try {
    const users = await User.find({ name: { $regex: name, $options: "i" } });

    if (!users) {
      return res.status(400).json({
        success: false,
        message: "No user found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Users found successfully",
      data: users,
    });
  } catch (err) {
    console.error(err.message);
    return res.status(400).json({
      success: false,
      message: "Users cannot be found. Please try again later.",
    });
  }
};
