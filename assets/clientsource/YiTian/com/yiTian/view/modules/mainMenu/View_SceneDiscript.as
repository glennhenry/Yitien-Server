package com.yiTian.view.modules.mainMenu
{
   import com.yiTian.Global;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.UIBase;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_SceneDiscript extends UIBase
   {
      
      private var disMC:MovieClip;
      
      private var interal:int;
      
      public function View_SceneDiscript()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function show(mapId:int) : void
      {
         MassLoader.add("resource/mapDiscript/" + mapId + ".swf",this.loadComp,null,MassLoader.LEVEL0);
      }
      
      private function loadComp(info:Object) : void
      {
         if(info.url.indexOf(Global.sceneMap) == -1)
         {
            return;
         }
         if(Boolean(this.disMC))
         {
            this.dispose();
         }
         this.disMC = info.content as MovieClip;
         if(Boolean(this.disMC))
         {
            addChild(this.disMC);
         }
         GameScene.downUIDisabledLayer.addChild(this);
         this.resetPosition();
         alpha = 1;
         this.interal = setTimeout(this.hide,2500);
      }
      
      private function hide() : void
      {
         clearTimeout(this.interal);
         Tween.to(this,1000,{"alpha":[1,0]},this.remove);
      }
      
      private function remove() : void
      {
         if(Boolean(this.disMC))
         {
            removeChild(this.disMC);
            this.disMC = null;
         }
         if(Boolean(this.parent))
         {
            parent.removeChild(this);
         }
      }
      
      override public function resetPosition() : void
      {
         if(Boolean(this.disMC))
         {
            this.disMC.x = Global.stage.stageWidth * 0.2;
            this.disMC.y = Global.stage.stageHeight / 2 - 230;
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(this.parent))
         {
            clearTimeout(this.interal);
            Tween.stop(this);
            this.remove();
         }
      }
   }
}

