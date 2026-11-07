package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.tianMing.View_TianMing;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public class View_HuaShanStrengthTip extends Panel123
   {
      
      private var ttf:TTFF;
      
      private var _bg:DisplayObject;
      
      public function View_HuaShanStrengthTip()
      {
         super();
         regResource("lang/ch/YiDao.swf","YiDaodm");
      }
      
      override protected function initUI2() : void
      {
         this._bg = ComponentUtil.getBitmap("YiDao_di",this,{
            "x":0,
            "y":0
         },Global.YiDaodm);
         ComponentUtil.getButton("","PYCW",this,{
            "x":231,
            "y":77,
            "callBack":this.petClickHd
         },Global.YiDaodm);
         ComponentUtil.getButton("","QHZb",this,{
            "x":113,
            "y":77,
            "callBack":this.qhClickHd
         },Global.YiDaodm);
         ComponentUtil.getButton("","SJTM",this,{
            "x":350,
            "y":77,
            "callBack":this.tmClickHd
         },Global.YiDaodm);
         ComponentUtil.getBitmap("ZiYin_1",this,{
            "x":81,
            "y":102
         },Global.YiDaodm);
         ComponentUtil.getBitmap("ZiYin_2",this,{
            "x":201,
            "y":103
         },Global.YiDaodm);
         ComponentUtil.getBitmap("ZiYin_3",this,{
            "x":319,
            "y":102
         },Global.YiDaodm);
         ComponentUtil.getTextField(LangConfig.getWord("29412",2),this,{
            "x":177,
            "y":17,
            "color":11904647
         });
         this.ttf = new TTFF();
         ComponentUtil.setPropertie(this.ttf,{
            "x":260,
            "y":14,
            "color":16776960,
            "size":16,
            "bold":true
         });
         this.ttf.type = TextFieldType.DYNAMIC;
         this.ttf.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.ttf);
         ComponentUtil.getTextField(LangConfig.getWord("29413",2),this,{
            "x":135,
            "y":51,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton(LangConfig.getWord("29087",2),"Button_Two64",this,{
            "x":224,
            "y":178,
            "textColor":11904647,
            "callBack":this.closeClickHd
         },Global.Img_Cdm);
      }
      
      public function show() : void
      {
         this.ttf.text = "";
         visible = true;
         pop(0.5,0.5,0.5,0.5,0.3,1,400,this.playTF);
      }
      
      public function playTF() : void
      {
         this.ttf.play(0,GameUnitManager.hero.strength);
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      private function qhClickHd(e:Event) : void
      {
         UIManager.castPanel.visible = !UIManager.castPanel.visible;
      }
      
      private function petClickHd(e:Event) : void
      {
         if(Boolean(UIManager.petPanel.petVO))
         {
            UIManager.petPanel.visible = !UIManager.petPanel.visible;
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10172",1));
         }
      }
      
      private function tmClickHd(e:Event) : void
      {
         View_TianMing.instance.visible = !View_TianMing.instance.visible;
      }
      
      private function closeClickHd(e:Event) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this._bg.width) / 2;
         y = (Global.stage.stageHeight - this._bg.height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.utils.Tween;
import flash.text.TextFieldAutoSize;

class TTFF extends MyTextField
{
   
   public function TTFF()
   {
      super();
   }
   
   public function play(s:int, e:int, time:int = 1300) : void
   {
      Tween.to(this,time,{"p":[s,e]},this.complete,null,this.tFun);
   }
   
   private function tFun(v:Number) : Number
   {
      return int(v * 10) / 10;
   }
   
   public function set p(num:int) : void
   {
      text = num.toString();
   }
   
   private function complete() : void
   {
      var tf:MyTextField = ComponentUtil.getTextField("",parent,{
         "size":16,
         "x":x,
         "y":y,
         "bold":true,
         "color":16776960
      });
      tf.autoSize = TextFieldAutoSize.LEFT;
      tf.text = text;
      Tween.to(tf,300,{
         "alpha":[1,0.2],
         "x":[x,x - textWidth * 2 / 2],
         "y":[y,y - textHeight * 2 / 2],
         "scaleX":[1,2 + 1],
         "scaleY":[1,2 + 1]
      },this.scaleComplete);
   }
   
   private function scaleComplete(tf:MyTextField) : void
   {
      parent.removeChild(tf);
      tf.scaleX = tf.scaleY = tf.alpha = 1;
      tf.dispose();
   }
}
