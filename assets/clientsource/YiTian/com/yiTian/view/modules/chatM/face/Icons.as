package com.yiTian.view.modules.chatM.face
{
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.modules.chatM.FaceChooser;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Icons extends Sprite
   {
      
      public var id:int;
      
      public var selFun:Function;
      
      private var faceArr:Array = [];
      
      public var startIndex:int;
      
      public var endIndex:int;
      
      private var isInitDic:Dictionary = new Dictionary();
      
      public function Icons()
      {
         super();
      }
      
      public function initSource() : void
      {
         if(!Model_face.dmDic[this.id])
         {
            MassLoader.add("lang/ch/FaceIcons_" + this.id + ".swf",function(info:Object):void
            {
               Model_face.dmDic[id] = info.applicationDomain;
               showFace();
            });
         }
         else
         {
            this.showFace();
         }
      }
      
      private function showFace() : void
      {
         var faceClass:Class = null;
         var face:MovieClip = null;
         var i:int = 0;
         i = 0;
         while(i < 36)
         {
            faceClass = Model_face.dmDic[this.id].getDefinition("Face" + (i + this.startIndex)) as Class;
            face = new faceClass();
            face.buttonMode = true;
            face.x = i % 6 * (20 + 4) + 7;
            face.y = int(i / 6) * (20 + 4) + 7;
            face.stop();
            face.addEventListener(MouseEvent.MOUSE_DOWN,this.faceDownHandle);
            face.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
            {
               mHandle(evt);
               selFun(int(getQualifiedClassName(evt.currentTarget as MovieClip).substring(4)));
            });
            addChild(face);
            this.faceArr.push(face);
            i++;
         }
         this.isInitDic[this.id] = true;
         this.setPlay(true);
      }
      
      private function faceDownHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function mHandle(e:MouseEvent = null) : void
      {
         var granParent:DisplayObject = e.target.parent.parent;
         var granGranParent:DisplayObject = granParent.parent;
         if(Boolean(granParent) && granParent is FaceChooser)
         {
            granParent.visible = false;
         }
         if(Boolean(granGranParent) && granGranParent is FaceChooser)
         {
            granGranParent.visible = false;
         }
      }
      
      private function setPlay(value:Boolean) : void
      {
         var str:String = value ? "play" : "stop";
         var i:int = 0;
         while(i < this.faceArr.length)
         {
            this.faceArr[i][str]();
            i++;
         }
      }
      
      public function show() : void
      {
         if(Boolean(this.isInitDic[this.id]))
         {
            this.setPlay(true);
         }
         else
         {
            this.initSource();
         }
         visible = visible || true;
      }
      
      public function hide() : void
      {
         visible = visible && false;
      }
   }
}

