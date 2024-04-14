const express = require("express");
const db = require("./config/database");
const router = require("./routes/UserRoute");
const fileUpload = require("express-fileupload");
const cloudinary = require("./config/cloudinary");
const http = require("http");
const socketIo = require("socket.io");
require("dotenv").config();
cloudinary.cloudinaryConnect();

const PORT = process.env.PORT || 3000;
const app = express();
const server = http.createServer(app);
const io = socketIo(server);

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

io.on("connection", (socket) => {
  console.log("New client connected: " + socket.id);

  socket.on("new_comment", (data) => {
    console.log(`Received new Comment data: ${JSON.stringify(data)}`);
    socket.broadcast.emit("notify_user", data);
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected: " + socket.id);
  });
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

db.dbConnect();
