package com.yiTian.view.modules.guide
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_guide_tip extends Sprite
   {
      
      private static var _instance:View_guide_tip;
      
      private var bg:ScaleBitmap;
      
      private var tf:MyTextField;
      
      private var _inter:int;
      
      public function View_guide_tip()
      {
         super();
         this.bg = ComponentUtil.getScaleBitmap("JuanZhou",[40,40,20,20],this,{
            "width":280,
            "height":94
         },Global.New_Imgsdm);
         this.tf = ComponentUtil.getTextField("",this,{
            "color":16753152,
            "size":30,
            "align":"center",
            "x":this.bg.x + 85,
            "y":this.bg.y + 32,
            "font":"KaiTi_GB2312"
         });
      }
      
      public static function get instance() : View_guide_tip
      {
         if(!_instance)
         {
            _instance = new View_guide_tip();
         }
         return _instance;
      }
      
      public function play(text:String) : void
      {
         Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
         this.tf.htmlText = text;
         this.bg.width = this.tf.textWidth + 170;
         alpha = 1;
         GameScene.upUILayer.addChild(this);
         this.resize();
         this._inter = setTimeout(this.hide,1500);
      }
      
      private function hide() : void
      {
         clearTimeout(this._inter);
         Tween.to(this,500,{
            "y":[y,y - 50],
            "alpha":[1,0.2]
         },this.remove);
      }
      
      private function remove() : void
      {
         Global.control.removeCallBack(Enum_MsgType.STAGE_RESIZE,this.resize);
         parent.removeChild(this);
      }
      
      private function resize() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2 - 150;
      }
   }
}

