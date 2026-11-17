---
title: Intro
slug: index
description: Intro
---

Yitien documentation.

### About the files

We found the Yitien files on Baidu Cloud through some Baidu AI search. We are so lucky to obtain this files.

The cloud says that the files was uploaded in 2026, but the server was developed around 2013-2015.

The files is actually a completely working and playable Yitien. It is quite advanced in terms of deployment as it works with a single `.exe` bundle which unpacks itself into game and server files. Software dependency like JRE, SQL, and Apache server are all included in the bundle. It combines an easy distribution and production-ready status in 2010s.

As far as I'm aware, there is no problem on running the game. However, we treated the server like it's a black box.

- Can't understand the installation tutorial (it didn't work anyway).
- We don't know whether the server is completed or not.
- There are some errors in the console, but unsure if they will affect the game or not.
- Not proficient in the game's language. Someone has to translate the Chinese texts and assets files into English for better playability.
- There are some known issues like player being stuck in certain quests.

For the long-term future access and seamless playability, eventually, someone has to comprehend the server. It might as well be better to migrate the server into a newer technology and English codebase that more people can understand. It also opens up for potential content expansion.

### Translation

Text files that are written in format like `strings.xml` is generally easy to translate.

However, texts embedded in assets like images or SWF is harder.

- For image files, we likely need to edit erase the CN text and replace it with English text with the identical fonts.
- For SWF, this could be easy because the overall sprite is composed of multiple images. The texts are isolated and therefore erasing it won't affect the rest of the image.

### Debugging

The game has built-in trace and memory viewer tools.

- Press Alt + Shift + Ctrl + S to see Flash `trace()` messages.
- Press Alt + Ctrl + Backspace to see memory and frame rates.

### Networking

Yitien socket protocol associates each message with a cmd (short for command, an integer). The payload itself is simple binary packing that is listed on each message's class.

The cmd undergo binary manipulation with some key supplied from the flashvars. Allegedly, this is used for obfuscation, that is making opcode less obvious.

Eventually, the binary process produces 2 result of `answer` and `answer2`. Both are integer which combines the opcode, flashvars' key, and some random number. Though, the payload itself is transported plainly.

The structure is basically:

```
[int 4 bytes] length of payload + 12
[int 4 bytes] answer2
[int 4 bytes] answer
[remaining bytes] body
```

#### Removing Obfuscation

It seems like there is no need to keep this obfuscation scheme as it won't enhance security. Additionally, with the client available, anyone can decompile it and create the reverse operation.

:::tips
The SWF we have is allegedly the non-release version that has trace debug and viewer enabled; so really, just by pressing `Alt + Shift + Ctrl + S` you can see the opcode directly.
:::

Original code that we removed (both `YiLoader.swf` and `YiTian.swf`):

```as3
private static function getRamdon() : int
{
   _lastRandValue += 1;
   if(_lastRandValue > 127)
   {
      _lastRandValue = 0;
   }
   return _lastRandValue;
}

if(socket.connected)
{
   evt = new TapperEvent("客户端发送");
   evt.param = [cmd,body];
   Global.stage.dispatchEvent(evt);
   socket.writeInt(body.length + 12);
   random = getRamdon();
   rel = (cmd << 5) + Global.key;
   i = 0;
   while(i < 8)
   {
      relIt = rel >> 3 * i & 7;
      randomItem = random >> i & 1;
      last = (randomItem << 3) + relIt << 4 * i;
      answer += last;
      i++;
   }
   i = 0;
   while(i < 5)
   {
      cmdIt = cmd >> 3 * i & 7;
      keyIt = Global.key >> i & 1;
      ranIt = random >> i & 1;
      if(Boolean(ranIt))
      {
         cmdkeyIt = (keyIt << 3) + cmdIt << 4 * i;
      }
      else
      {
         cmdkeyIt = (cmdIt << 1) + keyIt << 4 * i;
      }
      cmdAndKey += cmdkeyIt;
      i++;
   }
   cmdAndKey += cmd >> 15 << 20;
   moveKey = random >> 5;
   moveAbs = 32 - moveKey;
   answer2 = (cmdAndKey << moveKey) + (random << moveAbs >> moveAbs) + (random >> moveKey << 24 + moveKey);
   socket.writeInt(answer2);
   socket.writeInt(answer);
   if(cmd != 5027 && cmd != 5008)
   {
      Utils.print("sendServer",cmd);
   }
   socket.writeBytes(body);
   socket.flush();
}
```

The current code:

```as3
if(socket.connected)
{
   evt = new TapperEvent("客户端发送");
   evt.param = [cmd,body];
   Global.stage.dispatchEvent(evt);
   socket.writeInt(body.length + 4);
   socket.writeInt(cmd);
   if(cmd != 5027 && cmd != 5008)
   {
      Utils.print("sendServer",cmd);
   }
   socket.writeBytes(body);
   socket.flush();
}
```

_The YiTian.swf version does not have TapperEvent._

#### Message Convention

The server sends back response in similar structure but without obfuscating the opcode.

For XML based response, it must starts the XML declaration: `<?xml`.

Upon receiving the socket response, the client dispatch the message into the appropriate handler. Each handler is registered on their respective message class.

For example, `LoginGCMessage` registers the opcode `GC_ASK_LOGIN`. When the socket receives `GC_ASK_LOGIN` opcode, it will be routed to `LoginGCMessage`. The handling inside involves reading a result integer, then calling the static function of `LoginHandler` which does nothing but sending another request of `CG_ASK_CHARLIST`.

The pattern CG and GC means client to game (server) and game to client, respectively. In other word, CG messages are sent by client to the server.

Each CG message class contains code that packages the message in binary. Sending message is typically done by calling static function of the message class with payload encoded in the parameter.

:::tip
Having payload encoded in the parameter is a fortunate outcome, because parameter generally always have its variable name and type decompiled clearly.
:::

Each GC message class associates every related GC messages opcode with a function. The function contains code that reads the binary package, assembling the server's response into data that the client uses.

In the case of `LoginGCMessage` of `GC_ASK_LOGIN` opcode, the binary reading logic is nothing but reading a single data of result integer. Then, static function `LoginHandler.GC_ASK_LOGIN` is called.
