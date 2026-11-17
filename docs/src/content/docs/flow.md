---
title: Flow
slug: flow
description: Flow
---

This page should contain the game flow from loading to in-game. This will highlight noticeable client behavior and the part that interacts with the server.

### Connection Init

The game is loaded and it connects to the socket server directly using the supplied host and port from the flashvars.

The socket procedures exist within `SocketManager.as`. The first function used is the `loginLoginServer`.

- The first message is some HTTP GET like message. Unknown what is this for.
- The second message is directly sent. It is the `LoginCGMessage.CG_ASK_LOGIN` which sends the server the same account information retrieved from the flashvars.

The response should be `GC_ASK_LOGIN` with a success result which leads further to `CG_ASK_CHARLIST` message.

The response of charlist is `GC_ASK_CHARLIST`, which contains the characters of users.

### Game Startup

Then, the client will start sending `CG_HEARTBEAT` repeatedly.

After that, the `CG_ENTER_SCENE` is sent, passing a `roleId`. The response is `GC_ENTER_SCENE` with result, target `sceneId` (map), and coordinate x and y. The `sceneId` must conform to any of the available game maps at mapRes assets folder.
