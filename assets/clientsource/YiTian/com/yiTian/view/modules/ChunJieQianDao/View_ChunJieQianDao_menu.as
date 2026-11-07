package com.yiTian.view.modules.ChunJieQianDao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.net.message.cg.ChunJieQianDaoCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.geom.Rectangle;
   
   public class View_ChunJieQianDao_menu extends Panel123
   {
      
      private static var _instance:View_ChunJieQianDao_menu;
      
      public var icon:MainUIBtn;
      
      private var getPrizeBtn:Button;
      
      private var dayCountTxt:MyTextField;
      
      private var prizeTxt:MyTextField;
      
      private var vo:Vo_valuable;
      
      private var itemArr:Array;
      
      public function View_ChunJieQianDao_menu()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/GCQD.swf","CJQDdm");
      }
      
      public static function get instance() : View_ChunJieQianDao_menu
      {
         if(!_instance)
         {
            _instance = new View_ChunJieQianDao_menu();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var totalDay:int;
         var posArr:Array;
         var t_txt:MyTextField = null;
         var i:int = 0;
         var item:RiQi = null;
         var dayString:String = null;
         move = new Rectangle(0,0,550,30);
         ComponentUtil.getBitmap("Back_GCRW",this,{
            "x":478,
            "y":-30
         },Global.CJQDdm);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":496,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":446,
            "height":295
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":461,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_GCQD",this,{
            "x":168,
            "y":5
         },Global.CJQDdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":422,
            "height":271
         },Global.CJQDdm);
         ComponentUtil.getBitmap("Back_GCQD",this,{
            "x":35,
            "y":51
         },Global.CJQDdm);
         ComponentUtil.getTextField("1.点击可直接签到，签到成功后可获得周年庆礼包*5！\n2.5月8、11、14日签到可额外获得周年喜、迎字符奖励！\n3.公测周年庆签到无法补签！",this,{
            "x":99,
            "y":257,
            "color":16764206,
            "size":12,
            "leading":3
         });
         ComponentUtil.getBitmap("Text_GCQD",this,{
            "x":50,
            "y":63
         },Global.CJQDdm);
         ComponentUtil.getBitmap("Back_QDJL",this,{
            "x":519,
            "y":244
         },Global.CJQDdm);
         this.getPrizeBtn = ComponentUtil.getButton("","Button_QDJL",this,{
            "x":547,
            "y":289,
            "textColor":16771436
         },Global.CJQDdm);
         this.dayCountTxt = ComponentUtil.getTextField("",this,{
            "x":524,
            "y":248,
            "color":16764206,
            "size":12,
            "leading":3
         });
         this.dayCountTxt.htmlText = "累积签到<font color=\'#ff0000\'>" + "0/" + Data_lib.ChunJieQianDao[1][2] + "</font>天即可获得";
         this.prizeTxt = ComponentUtil.getTextField("公测纪念绝版时装一套！",this,{
            "x":593,
            "y":268,
            "color":14566855,
            "size":12,
            "leading":0
         },"center");
         this.itemArr = [];
         totalDay = int(Data_lib.ChunJieQianDao.getLength());
         posArr = [94,176,258,340];
         i = 0;
         while(i < totalDay)
         {
            item = new RiQi(i + 1);
            addChild(item);
            dayString = Data_lib.ChunJieQianDao[i + 1][4];
            dayString = dayString.replace("*","");
            item.txt = dayString.slice(0,2) + "\n" + dayString.slice(2);
            item.x = posArr[i % 4];
            item.y = i > 3 ? 194 : 137;
            this.itemArr.push(item);
            i++;
         }
         CloseButton.callBack = function():void
         {
            visible = false;
         };
         this.getPrizeBtn.callBack = function():void
         {
            ChunJieQianDaoCGMessage.CG_ChunJieQianDao_GET_PRIZE();
         };
         this.getPrizeBtn.enabled = false;
      }
      
      public function onIconClick(e:* = null) : void
      {
         ChunJieQianDaoCGMessage.CG_ChunJieQianDao_OPEN();
         this.visible = !this.visible;
      }
      
      public function setDate(signArr:Array, today:int, count:int, btnStatus:int) : void
      {
         var i:* = undefined;
         var nextGoal:int = 0;
         var isSign:Boolean = false;
         for(i in this.itemArr)
         {
            isSign = false;
            if(signArr.indexOf(int(i) + 1) != -1)
            {
               isSign = true;
            }
            (this.itemArr[i] as RiQi).setSign(isSign);
            (this.itemArr[i] as RiQi).setToday(today);
         }
         nextGoal = int(Data_lib.ChunJieQianDao[1][2]);
         if(count < nextGoal)
         {
            this.dayCountTxt.htmlText = "累积签到<font color=\'#ff0000\'>" + count + "/" + nextGoal + "</font>天即可获得";
         }
         else
         {
            this.dayCountTxt.htmlText = "累积签到<font color=\'#00ff00\'>" + count + "/" + nextGoal + "</font>天即可获得";
         }
         this.getPrizeBtn.enabled = btnStatus == 1 ? true : false;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import com.yiTian.net.message.cg.ChunJieQianDaoCGMessage;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flashx.textLayout.formats.TextAlign;

class RiQi extends Sprite
{
   
   private var id:int;
   
   private var _txt:MyTextField;
   
   private var eff:Effect;
   
   private var isTodayBitmap:Bitmap;
   
   private var isSignBitmap:Bitmap;
   
   public function RiQi(_id:int)
   {
      super();
      this.id = _id;
      ComponentUtil.getBitmap("Back_RiQi",this,{
         "x":0,
         "y":0
      },Global.CJQDdm);
      this.isTodayBitmap = ComponentUtil.getBitmap("Icon_Jin",this,{
         "x":42,
         "y":0
      },Global.CJQDdm);
      this.isTodayBitmap.visible = false;
      this.isSignBitmap = ComponentUtil.getBitmap("Icon_Gou",this,{
         "x":27,
         "y":17
      },Global.CJQDdm);
      this.isSignBitmap.visible = false;
      this._txt = ComponentUtil.getTextField("",this,{
         "x":31,
         "y":1,
         "color":16764206,
         "size":12,
         "leading":2
      },"center");
      this._txt.align = TextAlign.CENTER;
      this.mouseEnabled = false;
      this.addEventListener(MouseEvent.CLICK,this.onSign);
   }
   
   private function onSign(e:MouseEvent) : void
   {
      ChunJieQianDaoCGMessage.CG_ChunJieQianDao_SIGN(this.id);
   }
   
   public function get txt() : String
   {
      return this._txt.text;
   }
   
   public function set txt(value:String) : void
   {
      this._txt.text = value;
   }
   
   public function setToday(today:int) : void
   {
      if(this.id == today)
      {
         this.isTodayBitmap.visible = true;
         if(this.getSign())
         {
            this.effOff();
            this.mouseEnabled = false;
            this.buttonMode = false;
         }
         else
         {
            this.effOn();
            this.mouseEnabled = true;
            this.buttonMode = true;
         }
      }
      else
      {
         this.isTodayBitmap.visible = false;
         this.effOff();
         this.mouseEnabled = false;
         this.buttonMode = false;
      }
   }
   
   public function setSign(value:Boolean) : void
   {
      this.isSignBitmap.visible = value;
   }
   
   public function getSign() : Boolean
   {
      return this.isSignBitmap.visible;
   }
   
   private function effOn() : void
   {
      if(!this.eff)
      {
         this.eff = EffectManager.addEffect("35075",this,1000,34,6,true);
         this.eff.scaleY = 1.8;
      }
   }
   
   private function effOff() : void
   {
      if(Boolean(this.eff))
      {
         EffectManager.removeEffect(this.eff);
         this.eff = null;
      }
   }
}
