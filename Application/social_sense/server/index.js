const express = require("express");
const db = require("./config/database");
const router = require("./routes/UserRoute");
const app = express();

app.get("/", (req, res) => {
  res.send("API is Runnig for SocialScence.....");
});

app.use(express.json());
app.use("/api/v1", router);

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

db.dbConnect();
