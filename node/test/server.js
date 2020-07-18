const express = require("express");
const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("public", express.static("public"));

app.get("/", (req, res) => {
  res.sendfile("public/index.html");
});

app.post("/user", (req, res) => {
  //   const {
  //     query: { id, pw },
  //   } = req;

  console.log(req.body);

  // if (id == "1" && pw == "2") res.send("장진호");
  //   else res.sendStatus(403);

  res.json({
    message: "SUCCEWS",
  });
});

app.listen(PORT, () => {
  console.log(`Server listening on localhost:${PORT}`);
});
