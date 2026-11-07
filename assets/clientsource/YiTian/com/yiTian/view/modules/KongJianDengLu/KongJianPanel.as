package com.yiTian.view.modules.KongJianDengLu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KongJianCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel123;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class KongJianPanel extends Panel123
   {
      
      private var bt1:Button;
      
      private var bt2:Button;
      
      private var bt3:Button;
      
      private var tfLogo:MyTextField;
      
      private var OneDay:QQGiftItem;
      
      private var TwoDay:QQGiftItem;
      
      private var ThreeDay:QQGiftItem;
      
      public var arr:Array;
      
      private var btnVec:Vector.<Button>;
      
      private var isFirst:Boolean = true;
      
      public function KongJianPanel()
      {
         super();
      }
      
      private function initBtn() : void
      {
         var btn:Button = null;
         this.btnVec = new Vector.<Button>();
         var i:int = 0;
         while(i < 3)
         {
            btn = ComponentUtil.getButton("","Button_Orange",this,{
               "x":364,
               "y":123 + i * 46,
               "textColor":16184781,
               "name":"btn_" + (i + 1)
            },Global.Img_Cdm);
            this.btnVec.push(btn);
            i++;
         }
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = null;
         var arr2:Array = null;
         var i:int = 0;
         back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":526,
            "height":276
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":478,
            "height":226
         },Global.Img_Cdm);
         this.tfLogo = ComponentUtil.getTextField("",this,{
            "x":105,
            "y":56,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.tfLogo.multiline = true;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":110,
            "width":458,
            "height":146
         },Global.Img_Cdm);
         this.initBtn();
         this.OneDay = new QQGiftItem();
         this.OneDay.dayIndex.text = "第一天";
         arr2 = new Array();
         var j:int = 1;
         while(j <= 3)
         {
            this.arr = Data_lib.kjdl[j][0].toString().split(",");
            i = 0;
            while(i < this.arr.length)
            {
               arr2.push(this.arr[i].toString().split("_"));
               i++;
            }
            j++;
         }
         this.OneDay.vo.id = arr2[0][1];
         this.OneDay.vo.count = arr2[0][2];
         this.OneDay.vo.Init_lib();
         this.OneDay.grid.vo = this.OneDay.vo;
         this.OneDay.vo2.id = arr2[1][1];
         this.OneDay.vo2.count = arr2[1][2];
         this.OneDay.vo2.Init_lib();
         this.OneDay.grid2.vo = this.OneDay.vo2;
         this.OneDay.x = 37;
         this.OneDay.y = 113;
         addChild(this.OneDay);
         this.TwoDay = new QQGiftItem();
         this.TwoDay.dayIndex.text = "第二天";
         this.TwoDay.vo.id = arr2[2][1];
         this.TwoDay.vo.count = arr2[2][2];
         this.TwoDay.vo.Init_lib();
         this.TwoDay.grid.vo = this.TwoDay.vo;
         this.TwoDay.vo2.id = arr2[3][1];
         this.TwoDay.vo2.count = arr2[3][2];
         this.TwoDay.vo2.Init_lib();
         this.TwoDay.grid2.vo = this.TwoDay.vo2;
         this.TwoDay.x = 37;
         this.TwoDay.y = 159;
         addChild(this.TwoDay);
         this.ThreeDay = new QQGiftItem();
         this.ThreeDay.dayIndex.text = "第三天以后";
         this.ThreeDay.vo.id = arr2[4][1];
         this.ThreeDay.vo.count = arr2[4][2];
         this.ThreeDay.vo.Init_lib();
         this.ThreeDay.grid.vo = this.ThreeDay.vo;
         this.ThreeDay.vo2.id = arr2[5][1];
         this.ThreeDay.vo2.count = arr2[5][2];
         this.ThreeDay.vo2.Init_lib();
         this.ThreeDay.grid2.vo = this.ThreeDay.vo2;
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            this.OneDay.vo3.id = 44510;
            this.OneDay.vo3.count = 1;
            this.OneDay.vo3.Init_lib();
            this.OneDay.grid3.vo = this.OneDay.vo3;
            this.TwoDay.vo3.id = 44510;
            this.TwoDay.vo3.count = 1;
            this.TwoDay.vo3.Init_lib();
            this.TwoDay.grid3.vo = this.TwoDay.vo3;
            this.ThreeDay.vo3.id = 44510;
            this.ThreeDay.vo3.count = 1;
            this.ThreeDay.vo3.Init_lib();
            this.ThreeDay.grid3.vo = this.ThreeDay.vo3;
         }
         this.ThreeDay.x = 37;
         this.ThreeDay.y = 205;
         addChild(this.ThreeDay);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":492,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      public function Open() : void
      {
         var btn:Button = null;
         var j:int = 0;
         var i:int = 0;
         var str:String = Global.pf == Enum_SPStr.QQ3366 ? "3366" : "空间朋友网";
         this.tfLogo.htmlText = str + "登录游戏即可领取连续登录奖励<br>" + "若中途有中断登录则连续登录天数记录将清零";
         var day:int = KongJianVO.day - 1;
         var len:int = int(this.btnVec.length);
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            j = 0;
            while(j < len)
            {
               btn = this.btnVec[j];
               if(j < day)
               {
                  btn.enabled = false;
                  btn.label = "已领取";
               }
               else if(j == day)
               {
                  btn.enabled = true;
                  btn.label = "领取奖励";
                  btn.addEventListener(MouseEvent.CLICK,this.OneClick);
               }
               else if(j > day)
               {
                  btn.enabled = false;
                  btn.label = "未达条件";
               }
               j++;
            }
         }
         else
         {
            i = 0;
            while(i < len)
            {
               btn = this.btnVec[i];
               if(i == day)
               {
                  btn.enabled = true;
                  btn.label = "领取奖励";
                  btn.addEventListener(MouseEvent.CLICK,this.OneClick);
               }
               else
               {
                  btn.enabled = false;
                  btn.label = "未达条件";
               }
               i++;
            }
         }
      }
      
      public function close() : void
      {
         var btn:Button = null;
         if(KongJianVO._SafeStr_1 == 1)
         {
            if(KongJianVO.day == 1)
            {
               ComboTweenStep.toBag(this.OneDay.grid);
               ComboTweenStep.toBag(this.OneDay.grid2);
               if(Global.pf == Enum_SPStr.QQ3366)
               {
                  ComboTweenStep.toBag(this.OneDay.grid3);
               }
            }
            else if(KongJianVO.day == 2)
            {
               ComboTweenStep.toBag(this.TwoDay.grid);
               ComboTweenStep.toBag(this.TwoDay.grid2);
               if(Global.pf == Enum_SPStr.QQ3366)
               {
                  ComboTweenStep.toBag(this.TwoDay.grid3);
               }
            }
            else if(KongJianVO.day == 3)
            {
               ComboTweenStep.toBag(this.ThreeDay.grid);
               ComboTweenStep.toBag(this.ThreeDay.grid2);
               if(Global.pf == Enum_SPStr.QQ3366)
               {
                  ComboTweenStep.toBag(this.ThreeDay.grid3);
               }
            }
            btn = this.btnVec[KongJianVO.day - 1];
            btn.removeEventListener(MouseEvent.CLICK,this.OneClick);
            UIManager.kongjian.visible = false;
         }
         else if(KongJianVO._SafeStr_1 == 2)
         {
            UIManager.centerBroadcast.addMsg("背包已满，无法领取奖励");
         }
      }
      
      private function OneClick(e:MouseEvent) : void
      {
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            KongJianCGMessage.CG_LINGQU_DENGLU_3366();
            return;
         }
         var day:int = int(e.target.name.split("_")[1]);
         KongJianCGMessage.CG_DAY_KONGJIAN(day);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirst)
            {
               if(Global.pf == Enum_SPStr.QQ3366)
               {
                  if(!Global.XSGIFT3366_Imgsdm)
                  {
                     regResource("lang/ch/3366_Imgs.swf","XSGIFT3366_Imgsdm");
                  }
                  else
                  {
                     this.initUI2();
                  }
               }
               else
               {
                  regResource("lang/ch/QQZone_Imgs.swf","QQZone_Imgsdm");
               }
               preFun();
               this.isFirst = false;
            }
         }
      }
      
      override protected function initUI2() : void
      {
         if(Global.pf == Enum_SPStr.QQ3366)
         {
            ComponentUtil.getBitmap("Title_3366Award_2",this,{
               "x":163,
               "y":5
            },Global.XSGIFT3366_Imgsdm);
            ComponentUtil.getBitmap("Icons",this,{
               "x":43,
               "y":50
            },Global.XSGIFT3366_Imgsdm);
         }
         else
         {
            ComponentUtil.getBitmap("Title_QQZone",this,{
               "x":143,
               "y":5
            },Global.QQZone_Imgsdm);
            ComponentUtil.getBitmap("QQ_Zone",this,{
               "x":34,
               "y":50
            },Global.QQZone_Imgsdm);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "get"
 */
