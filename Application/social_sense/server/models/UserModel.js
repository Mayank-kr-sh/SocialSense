const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  password: {
    required: true,
    type: String,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  profilepic: {
    type: String,
  },
  bio: {
    type: String,
  },
  phone: {
    type: String,
  },
  dob: {
    type: String,
  },
  posts: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Post",
    },
  ],
});

module.exports = User = mongoose.model("User", userSchema);
