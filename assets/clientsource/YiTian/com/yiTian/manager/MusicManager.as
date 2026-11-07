package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.utils.MassLoader;
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MusicManager extends EventDispatcher
   {
      
      private static var instance:MusicManager;
      
      private static var interval:int;
      
      private var soundDic:Dictionary;
      
      private var soundChannel:SoundChannel;
      
      private var sceneSound:Sound;
      
      private var lastMusicUrl:String;
      
      public var isPlaying:Boolean = false;
      
      public var isLoading:Boolean = false;
      
      private var _sceneVolume:Number = 0.5;
      
      private var _soundVolume:Number = 0.5;
      
      public var allSound:Number;
      
      private var _soundLibraryFunc:Function;
      
      private var playTime:Number;
      
      public function MusicManager()
      {
         super();
         this.init();
      }
      
      public static function getInstance() : MusicManager
      {
         if(instance == null)
         {
            instance = new MusicManager();
         }
         return instance;
      }
      
      public static function getSound(type:String) : Sound
      {
         var cla:Class = null;
         if(Boolean(Global.musicDm))
         {
            cla = Global.musicDm.getDefinition(type) as Class;
            return new cla();
         }
         return null;
      }
      
      private function init() : void
      {
         this.soundDic = new Dictionary();
      }
      
      public function get sceneVolume() : Number
      {
         return this._sceneVolume;
      }
      
      public function set sceneVolume(value:Number) : void
      {
         this._sceneVolume = value;
         this.setSceneVolume(this._sceneVolume);
      }
      
      public function get soundVolume() : Number
      {
         return this._soundVolume;
      }
      
      public function set soundVolume(value:Number) : void
      {
         this._soundVolume = value;
      }
      
      public function set allVolume(value:Number) : void
      {
         this.soundVolume = value;
         this.sceneVolume = value;
         this.allSound = value;
      }
      
      public function get allVolume() : Number
      {
         return this.allSound;
      }
      
      public function set soundLibraryFunc(func:Function) : void
      {
         this._soundLibraryFunc = func;
      }
      
      public function get soundLibraryFunc() : Function
      {
         return this._soundLibraryFunc;
      }
      
      public function playMusic(url:String) : void
      {
         var sound:Sound = null;
         if(this.allSound == 0)
         {
            return;
         }
         if(url != this.lastMusicUrl)
         {
            if(Boolean(this.sceneSound))
            {
               try
               {
                  this.sceneSound.removeEventListener(Event.COMPLETE,this.onLoadComplete);
                  this.sceneSound.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
                  this.sceneSound.close();
               }
               catch(e:*)
               {
               }
            }
            if(Boolean(this.soundChannel))
            {
               this.soundChannel.stop();
            }
            sound = this.soundDic[url];
            this.lastMusicUrl = url;
            if(Boolean(sound))
            {
               this.sceneSound = sound;
               this.startPlay();
            }
            else
            {
               this.sceneSound = new Sound();
               this.sceneSound.load(new URLRequest((Boolean(Global.config.mapUrl) ? Global.config.mapUrl : "") + MassLoader.makePath(url)));
               this.sceneSound.addEventListener(Event.COMPLETE,this.onLoadComplete);
               this.sceneSound.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
               this.isLoading = true;
            }
         }
         else if(this.isPlaying == false)
         {
            if(Boolean(this.sceneSound))
            {
               this.startPlay();
            }
         }
      }
      
      private function onLoadComplete(event:Event) : void
      {
         if(Boolean(this.soundChannel))
         {
            this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            this.soundChannel.stop();
         }
         this.soundDic[this.lastMusicUrl] = this.sceneSound;
         this.startPlay();
      }
      
      private function startPlay() : void
      {
         clearTimeout(interval);
         if(Boolean(this.sceneSound))
         {
            this.soundChannel = this.sceneSound.play(0,0,new SoundTransform(this.sceneVolume));
            if(Boolean(this.soundChannel))
            {
               this.soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            }
            this.isPlaying = true;
            this.isLoading = false;
         }
      }
      
      private function onSoundComplete(event:Event) : void
      {
         this.isPlaying = false;
         clearTimeout(interval);
         interval = setTimeout(this.playMusic,10000,this.lastMusicUrl);
      }
      
      private function onIOError(event:IOErrorEvent) : void
      {
         this.lastMusicUrl = "";
         this.isLoading = false;
      }
      
      public function stopMusic() : void
      {
         if(this.isLoading && Boolean(this.sceneSound))
         {
            try
            {
               this.sceneSound.removeEventListener(Event.COMPLETE,this.onLoadComplete);
               this.sceneSound.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
               this.sceneSound.close();
               this.sceneSound = null;
            }
            catch(e:*)
            {
            }
         }
         if(Boolean(this.soundChannel))
         {
            this.soundChannel.stop();
         }
         this.lastMusicUrl = "";
         this.isPlaying = false;
      }
      
      public function pauseMusic() : void
      {
         this.setSceneVolume(0);
         if(Boolean(this.soundChannel))
         {
            this.playTime = this.soundChannel.position;
            this.soundChannel.stop();
            this.isPlaying = false;
         }
      }
      
      public function playSound(type:String) : void
      {
         if(this._soundVolume == 0)
         {
            return;
         }
         var sound:Sound = this.soundDic[type];
         if(sound == null)
         {
            sound = getSound(type);
            if(sound == null)
            {
               return;
            }
            this.soundDic[type] = sound;
         }
         sound.play();
      }
      
      public function removeSound(type:String) : void
      {
         var sound:Sound = this.soundDic[type];
         if(Boolean(sound))
         {
            try
            {
               sound.close();
            }
            catch(e:IOError)
            {
            }
            sound = null;
            this.soundDic[type] = null;
         }
      }
      
      private function setSceneVolume(vol:Number) : void
      {
         var soundTransform:SoundTransform = new SoundTransform(vol);
         if(Boolean(this.soundChannel))
         {
            this.soundChannel.soundTransform = soundTransform;
         }
      }
   }
}

