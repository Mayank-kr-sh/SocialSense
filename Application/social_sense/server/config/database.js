const mongoose = require("mongoose");

exports.dbConnect = () => {
  mongoose
    .connect(
      "mongodb+srv://mayankkiiit:UdmM8AlgHiZHVhgX@cluster0.ravr2gf.mongodb.net/Data?retryWrites=true&w=majority&appName=Cluster0"
    )
    .then(() => {
      console.log("Connected to database");
    })
    .catch((err) => {
      console.log("DB connection error:", err);
    });
};

//mayankkiiit
//UdmM8AlgHiZHVhgX
