---
title: Flow
slug: flow
description: Flow
---

This page should contain the game flow from loading to in-game. This will highlight noticeable client behavior and the part that interacts with the server.

### Init

The game is loaded and it connects to the socket server directly using the supplied host and port from the flashvars.

The socket procedures exist within `SocketManager.as`. The first function used is the `loginLoginServer`.

- The first message is some HTTP GET like message. Unknown what is this for.
- The second message is directly send. It is the `LoginCGMessage.CG_ASK_LOGIN` which sends the server the same account information retrieved from the flashvars.
