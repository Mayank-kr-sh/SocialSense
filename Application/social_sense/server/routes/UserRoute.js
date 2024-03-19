const express = require("express");
const router = express.Router();
const protected = require("../middlewares/auth");
const { register, login, update } = require("../controllers/UserController");
const { upload } = require("../controllers/UploadController");

router.post("/", register);
router.post("/login", login);
router.post("/update", protected, update);
router.post("/:userId/upload", protected, upload);

module.exports = router;
