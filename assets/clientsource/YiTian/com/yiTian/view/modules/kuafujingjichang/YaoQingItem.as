package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class YaoQingItem extends Sprite
   {
      
      public var back:ScaleBitmap;
      
      public var heroZhi:MyTextField;
      
      public var heroname:MyTextField;
      
      public var herolevel:MyTextField;
      
      public var YQbtn:Button;
      
      public var id:Number = 0;
      
      public function YaoQingItem()
      {
         super();
         this.back = ComponentUtil.getScaleBitmap("ListBack",[5,5,2,2],this,{
            "x":0,
            "y":0,
            "width":334,
            "height":32
         },Global.Img_Cdm);
         this.heroZhi = ComponentUtil.getTextField("玩家职业",this,{
            "x":13,
            "y":6,
            "color":8896312,
            "size":12,
            "leading":0
         });
         this.heroname = ComponentUtil.getTextField("玩家中文名字",this,{
            "x":101,
            "y":6,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.herolevel = ComponentUtil.getTextField("000",this,{
            "x":205,
            "y":6,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.YQbtn = ComponentUtil.getButton("邀请","Button_GreenTwo",this,{
            "x":261,
            "y":3,
            "textColor":16184781
         },Global.Img_Cdm);
         this.YQbtn.addEventListener(MouseEvent.CLICK,this.YQClick);
      }
      
      private function YQClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_KUAFUTEAM_YAOQING(this.id);
      }
   }
}

