const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const messages = [];

const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const methodOverride = require("method-override");

const authRouter = require("./routes/auth");
const indexRouter = require("./routes/index");
const User = require("./models/user");
const Chat = require("./models/chats");

const DB =
  "mongodb+srv://dexterjay26:PervySage123@cluster0.dlfud.mongodb.net/?retryWrites=true&w=majority";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connnection Success");
  })
  .catch((e) => console.log(e));

app.use(cookieParser());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.set("socketio", io);

app.use(indexRouter);
app.use(authRouter);

io.on("connection", async (socket) => {
  const email = socket.handshake.query.email;
  const user = await User.findOne({ email: email });

  socket.on("join-chat", (data) => {
    socket.join(data);
    console.log("Joined to");
    console.log(data);
  });

  socket.on("message", async (data) => {
    const chat = await Chat.findById(data.chatId);

    const message = {
      chat: data.message,
      author: user._id.toString(),
      timeStamp: data.timeStamp,
    };
    chat.chats.push(message);

    await chat.save();
    io.to(chat._id.toString()).emit("message", message);

    console.log(message);
  });

  socket.on("unsubscribe", (chatId) => {
    try {
      socket.leave(chatId);
    } catch (e) {
      console.log("[error]", "leave room :", e);
      socket.emit("error", "couldnt perform requested action");
    }
  });

  const sockets = await io.fetchSockets();

  console.log("Connected Users: " + sockets.length);
  for (const s of sockets) {
    console.log(`ID: ${s.id} email: ${s.handshake.query.email},`);
  }
  console.log("===============");
});

server.listen(3000, "192.168.254.101", () => {
  console.log("listening on *:3000");
});
