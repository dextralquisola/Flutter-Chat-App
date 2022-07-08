const mongoose = require("mongoose");

const chatsSchema = mongoose.Schema({
  chats: [
    {
      chat: {
        type: String,
        required: true,
      },
      author: {
        type: String,
        required: true,
      },
      timeStamp: {
        type: String,
        required: true,
      },
    },
  ],
});

const Chat = mongoose.model("Chat", chatsSchema);

module.exports = Chat;
