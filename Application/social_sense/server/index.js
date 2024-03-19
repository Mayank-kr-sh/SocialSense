const express = require("express");
const db = require("./config/database");
const router = require("./routes/UserRoute");
const fileUpload = require("express-fileupload");
const cloudinary = require("./config/cloudinary");
require("dotenv").config();
cloudinary.cloudinaryConnect();

const PORT = process.env.PORT || 3000;
const app = express();

app.get("/", (req, res) => {
  res.send("API is Runnig for SocialScence.....");
});

app.use(express.json());
app.use(
  fileUpload({
    useTempFiles: true,
    tempFileDir: "/tmp/",
  })
);

app.use("/api/v1", router);

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

db.dbConnect();
