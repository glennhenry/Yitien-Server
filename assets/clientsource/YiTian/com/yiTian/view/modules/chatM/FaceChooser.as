package com.yiTian.view.modules.chatM
{
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.modules.chatM.face.ExtralFace;
   import com.yiTian.view.modules.chatM.face.Model_face;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   
   public class FaceChooser extends Sprite
   {
      
      private static var _instance:FaceChooser;
      
      public static const FACE_ICON_SIZE:int = 20;
      
      private var faceArr:Array = [];
      
      private var _selFun:Function;
      
      private var extralFacePart:ExtralFace;
      
      private var isShowExtralFace:Boolean;
      
      public function FaceChooser()
      {
         super();
         GameScene.sysLayer.addChild(this);
         mouseChildren = true;
      }
      
      public static function get instance() : FaceChooser
      {
         if(!_instance)
         {
            _instance = new FaceChooser();
         }
         return _instance;
      }
      
      public function init(selFun:Function) : void
      {
         var bg:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":160,
            "height":160
         },Global.Img_Cdm);
         addChild(bg);
         this.initSource(selFun);
      }
      
      private function initSource(selFun:Function, startIndex:int = 0, endIndex:int = 36, _parent:DisplayObjectContainer = null) : void
      {
         this._selFun = selFun;
         if(!Global.faceDm)
         {
            MassLoader.add("lang/" + Global.config.lang + "/FaceIcons.swf",function(info:Object):void
            {
               Global.faceDm = info.applicationDomain;
               initFace(selFun,startIndex,endIndex,_parent);
            });
         }
         else
         {
            this.initFace(selFun,startIndex,endIndex,_parent);
         }
      }
      
      private function initFace(selFun:Function, startIndex:int = 0, endIndex:int = 36, _parent:DisplayObjectContainer = null) : void
      {
         var faceClass:Class = null;
         var face:MovieClip = null;
         var i:int = 0;
         var _p:DisplayObjectContainer = null;
         i = startIndex;
         while(i < endIndex)
         {
            faceClass = Global.faceDm.getDefinition("Face" + (i + 1)) as Class;
            face = new faceClass();
            face.buttonMode = true;
            face.x = (i - startIndex) % 6 * (FACE_ICON_SIZE + 4) + 7;
            face.y = int((i - startIndex) / 6) * (FACE_ICON_SIZE + 4) + 7;
            face.stop();
            face.addEventListener(MouseEvent.MOUSE_DOWN,this.faceDownHandle);
            face.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
            {
               mHandle();
               _selFun(int(getQualifiedClassName(evt.currentTarget as MovieClip).substring(4)));
            });
            _p = _parent;
            if(_p == null)
            {
               _p = this;
            }
            _p.addChild(face);
            this.faceArr.push(face);
            i++;
         }
      }
      
      protected function faceDownHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      protected function setPlay(value:Boolean) : void
      {
         var str:String = value ? "play" : "stop";
         var i:int = 0;
         while(i < this.faceArr.length)
         {
            this.faceArr[i][str]();
            i++;
         }
      }
      
      private function mHandle(e:MouseEvent = null) : void
      {
         this.visible = false;
      }
      
      private function showPig() : void
      {
         if(!this.extralFacePart)
         {
            this.extralFacePart = new ExtralFace();
            ComponentUtil.setPropertie(this.extralFacePart,{
               "x":154,
               "y":0
            });
            addChild(this.extralFacePart);
         }
         this.extralFacePart.selFun = this._selFun;
         this.extralFacePart.show();
      }
      
      public function hidePig() : void
      {
         if(Boolean(this.extralFacePart))
         {
            removeChild(this.extralFacePart);
         }
         this.extralFacePart = null;
      }
      
      private function handldeOfFace() : void
      {
         var time:int = 0;
         this.isShowExtralFace = false;
         var i:int = 0;
         while(i < Model_face.data.length)
         {
            time = int(Model_face.data[i][1]);
            if(time > 0)
            {
               this.isShowExtralFace = true;
            }
            i++;
         }
         if(GameUnitManager.hero.vip > 0)
         {
            this.isShowExtralFace = true;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         }
         else
         {
            Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
            this.handldeOfFace();
            if(this.isShowExtralFace)
            {
               this.showPig();
            }
            else
            {
               this.hidePig();
            }
         }
         this.setPlay(value);
      }
   }
}

