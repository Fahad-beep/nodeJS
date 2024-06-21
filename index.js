const db = require("./config/db.js");
const app = require("./app.js");
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("Hello main page");
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
