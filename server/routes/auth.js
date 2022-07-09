require("dotenv").config();

const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const auth = require("../middleware/auth");

const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({
      email: email,
    });

    if (existingUser) {
      return res.status(400).json({
        msg: "User with same email already exists!",
      });
    }

    const encryptedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: encryptedPassword,
      name,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log(e);
  }
});

// Sign in Route

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exists" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password" });
    }

    const populatedUser = await (
      await user.populate("friendRequests", "_id name email")
    ).populate("friends.friend", "_id name email");

    console.log(populatedUser);

    const token = jwt.sign({ id: user._id }, process.env.PRIVATE_KEY);
    console.log({ token, ...populatedUser._doc });
    res.json({ token, ...populatedUser._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);

    const verified = jwt.verify(token, process.env.PRIVATE_KEY);
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);

    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/api/user", auth, async (req, res) => {
  const user = await User.findById(req.user);

  const populatedUser = await (
    await user.populate("friendRequests", "_id name email")
  ).populate("friends.friend", "_id name email");

  console.log(populatedUser);

  res.json({
    ...populatedUser._doc,
    token: req.token,
  });
});

module.exports = authRouter;
