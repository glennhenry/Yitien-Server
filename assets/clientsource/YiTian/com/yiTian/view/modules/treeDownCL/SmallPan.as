package com.yiTian.view.modules.treeDownCL
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Sprite;
   
   public class SmallPan extends Sprite
   {
      
      protected var source:String = "";
      
      protected var img_str:String = "";
      
      protected var isInit:Boolean = false;
      
      public function SmallPan()
      {
         super();
         GameScene.uiLayer.addChild(this);
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resetPosition);
      }
      
      protected function regSource(sImg:String, sSource:String) : void
      {
         this.img_str = sImg;
         this.source = sSource;
      }
      
      protected function initSource() : void
      {
      }
      
      protected function init(obj:Object, callBack:Function) : void
      {
         if(!this.isInit)
         {
            if(!Global[this.img_str])
            {
               SingleLoader.add("lang/ch/" + this.source + ".swf",function(info:Object):void
               {
                  Global[img_str] = info.applicationDomain;
                  initSource();
                  isInit = true;
                  if(Boolean(callBack.length))
                  {
                     callBack(obj);
                  }
                  else
                  {
                     callBack();
                  }
                  resetPosition();
               });
            }
            else
            {
               this.initSource();
               this.isInit = true;
               if(Boolean(callBack.length))
               {
                  callBack(obj);
               }
               else
               {
                  callBack();
               }
               this.resetPosition();
            }
         }
         else
         {
            if(Boolean(callBack.length))
            {
               callBack(obj);
            }
            else
            {
               callBack();
            }
            this.resetPosition();
         }
      }
      
      protected function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

