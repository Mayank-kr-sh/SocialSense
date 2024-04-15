const mongoose = require("mongoose");
require("dotenv").config();

exports.dbConnect = () => {
  mongoose
    .connect(process.env.MONGO_URI)
    .then(() => {
      console.log("Connected to database");
    })
    .catch((err) => {
      console.log("DB connection error:", err);
    });
};

//mayankkiiit
//UdmM8AlgHiZHVhgX
