const express = require("express");
const router = express.Router();
const protected = require("../middlewares/auth");
const { register, login, update } = require("../controllers/UserController");

router.post("/", register);
router.post("/login", login);
router.post("/update", protected, update);

module.exports = router;
