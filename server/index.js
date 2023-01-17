import express from "express";
import { WebSocketServer, WebSocket } from "ws";
import { createUserId } from "./utils.js";

const app = express();
import http from "http";
const server = http.createServer(app);
const io = new WebSocketServer({ server });
app.get("/", (req, res) => {
  res.send("<h1>What's good</h1>");
});

var users = {};

io.on("connection", (socket, req) => {
  try {
    console.log("a user connected");
    let userId = createUserId(users);
    users[userId] = "user" + (Object.keys(users).length + 1);
    socket.id = userId;
    console.log(users);
  } catch (e) {
    console.error(e);
  }
  socket.on("disconnect", () => {
    console.log("user disconnected");
  });

  socket.on("message", (msg) => {
    let data = msg;
    console.log("received: %s\nfrom: %s", data, socket.id);
    io.clients.forEach((client) => {
      console.log("sending to client: ", client.id);
      if (client.readyState === WebSocket.OPEN) {
        let messageObj = {
          user: users[socket.id] || "unknown",
          message: msg.toString(),
        };
        client.send(JSON.stringify(messageObj));
      }
    });
  });
});

server.listen(3000, () => {
  console.log("listening on *:3000");
});
