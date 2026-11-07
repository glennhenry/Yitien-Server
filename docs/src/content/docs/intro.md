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
