package com.yiTian.view.modules.actions.huoYueDu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class ProgressItem extends Sprite
   {
      
      private var __tf:MyTextField;
      
      private var maskSp:Sprite;
      
      public function ProgressItem()
      {
         var tf:MyTextField;
         var pro:Bitmap;
         super();
         ComponentUtil.getTextField("更多精彩玩法，尽在",this,{
            "x":2,
            "y":12,
            "color":13684779,
            "size":12,
            "leading":0
         });
         tf = ComponentUtil.getTextField("",this,{
            "x":112,
            "y":12,
            "color":575006,
            "size":12,
            "leading":0
         });
         tf.mouseEnabled = true;
         tf.htmlText = HtmlUtil.link(HtmlUtil.underLine("倚天秘籍"),"ss");
         tf.addEventListener(TextEvent.LINK,function(e:TextEvent):void
         {
            UIManager.smallMap.huoClick();
         });
         ComponentUtil.getBitmap("Back_Progress",this,{
            "x":205 + 50,
            "y":8
         },Global.HuoYue_Imgsdm);
         pro = ComponentUtil.getBitmap("Progress",this,{
            "x":209 + 50,
            "y":12
         },Global.HuoYue_Imgsdm);
         this.maskSp = new Sprite();
         this.maskSp.graphics.beginFill(0,0);
         this.maskSp.graphics.drawRect(0,0,300,6);
         this.maskSp.graphics.endFill();
         ComponentUtil.setPropertie(this.maskSp,{
            "x":209 + 50,
            "y":12
         });
         addChild(this.maskSp);
         pro.mask = this.maskSp;
         ComponentUtil.getTextField("20",this,{
            "x":260 + 50,
            "y":22,
            "color":58918,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("40",this,{
            "x":320 + 50,
            "y":22,
            "color":58918,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("60",this,{
            "x":380 + 50,
            "y":22,
            "color":58918,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("80",this,{
            "x":440 + 50,
            "y":22,
            "color":58918,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("100",this,{
            "x":500 + 50,
            "y":22,
            "color":58918,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Text_HuoYue",this,{
            "x":522 + 50,
            "y":6
         },Global.HuoYue_Imgsdm);
         this.__tf = ComponentUtil.getTextField("000",this,{
            "x":522 + 50,
            "y":22,
            "color":16776960,
            "size":12,
            "leading":0,
            "realWidth":78,
            "align":TextAlign.CENTER,
            "bold":true
         });
      }
      
      public function updateCurHuoYueDu(huoYueDu:int) : void
      {
         this.__tf.text = huoYueDu.toString();
         this.maskSp.width = huoYueDu / 100 * 300;
      }
   }
}

