const express = require("express");
const router = express.Router();
const protected = require("../middlewares/auth");
const {
  register,
  login,
  update,
  searchUser,
} = require("../controllers/UserController");
const { upload } = require("../controllers/UploadController");
const {
  fetchPosts,
  fetchUserPosts,
  fetchUserComments,
} = require("../controllers/PostController");
const { comment, deleteComment } = require("../controllers/CommentController");
const { like } = require("../controllers/LikeController");

router.post("/", register);
router.post("/login", login);
router.post("/update", protected, update);
router.post("/:userId/upload", protected, upload);
router.get("/fetch", protected, fetchPosts);
router.post("/comment/:postId", protected, comment);
router.delete("/delete/:commentId", protected, deleteComment);
router.post("/like/:postId", protected, like);
router.get("/fetch/:userId", protected, fetchUserPosts);
router.get("/comments/:userId", protected, fetchUserComments);
router.get("/search", protected, searchUser);

module.exports = router;
