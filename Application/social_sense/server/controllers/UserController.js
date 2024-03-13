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

    const token = jwt.sign(payload, "Mayank", {
      expiresIn: 3600,
    });

    const data = {
      id: user.id,
      name: user.name,
      email: user.email,
      token,
    };

    return res.status(200).json({
      success: true,
      message: "User logged in successfully",
      data,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Login Server Error", err.message);
  }
};
