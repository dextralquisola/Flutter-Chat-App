const express = require("express");

const User = require("../models/user");
const auth = require("../middleware/auth");

const Chat = require("../models/chats");
const { json } = require("body-parser");

const indexRouter = express.Router();

indexRouter.post("/api/addfriend", auth, async (req, res) => {
  try {
    var io = req.app.get("socketio");
    var user = await User.findOne({ email: req.body.email });

    //console.log(user);

    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exists" });
    }

    const sockets = await io.fetchSockets();

    var socketId = "";
    for (const s of sockets) {
      //console.log(`ID: ${s.id} email: ${s.handshake.query.username},`);
      if (user.email === s.handshake.query.email) {
        socketId = s.id;
        break;
      }
    }

    // console.log('ETO NA ID MO');
    // console.log(socketId);

    user.friendRequests.push(req.user);
    await user.save();

    user.populate("friendRequests", "_id name email").then((data) => {
      if (socketId != "") {
        io.to(socketId).emit("friend-request", data);
      }
    });

    res.json(user);
  } catch (e) {
    console.log(e);
  }
});

indexRouter.post("/api/accept-friend", auth, async (req, res) => {
  try {
    var io = req.app.get("socketio");

    //The user that sent a friend request
    var userSen = await User.findOne({ email: req.body.email });

    //The user that received the friend request
    var userRec = await User.findById(req.user);

    var newChat = new Chat();

    userRec.friends.push({ chatId: newChat._id, friend: userSen._id });
    userSen.friends.push({ chatId: newChat._id, friend: userRec._id });

    userRec.friendRequests.pull({ _id: userSen._id });

    const sockets = await io.fetchSockets();

    await userRec.save();
    await userSen.save();
    await newChat.save();

    var socketId = [];
    for (const s of sockets) {
      if (
        userRec.email === s.handshake.query.email ||
        userSen.email === s.handshake.query.email
      ) {
        socketId.push(s.id);

        var data = userRec.email === s.handshake.query.email ? userRec : userSen;

        data.populate("friends.friend", "_id name email").then((result) => {
          io.to(s.id).emit("friend-request", result);
        });

        if (socketId.length === 2) break;
      }
    }

    res.json({
      userSen,
      userRec,
    });
  } catch (error) {
    console.log(error);
  }
});

// For Chat Initialization
indexRouter.post("/api/fetch-chats", auth, async (req, res) => {
  const chats = await Chat.findById(req.body.chatId);
  res.json(chats);
});



module.exports = indexRouter;
