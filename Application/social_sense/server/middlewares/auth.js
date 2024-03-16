const jwt = require("jsonwebtoken");

const protected = (req, res, next) => {
  // Get the token from the request header
  const token = req.header("Authorization");

  if (!token) {
    return res.status(401).json({ error: "Authorization denied" });
  }

  try {
    const decoded = jwt.verify(token.replace("Bearer ", ""), "Mayank");
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ error: "Invalid token" });
  }
};

module.exports = protected;
