package com.yiTian.view.modules.ShengDan
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.ShengDanCGMessage;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ShengDanPanel extends Panel123
   {
      
      private var btnHaoYou:Button;
      
      private var btnXuFei:Button;
      
      private var btnKaiTong:Button;
      
      private var yellowIndex:MyTextField;
      
      private var arrVO:Array;
      
      private var spr1:sp222;
      
      private var spr2:sp222;
      
      private var spr3:sp222;
      
      private var spr4:sp222;
      
      private var spr5:sp222;
      
      private var spr6:sp222;
      
      private var back:DisplayObject;
      
      private var snowComboBox:ComboBox;
      
      private var timetf:MyTextField;
      
      private var xgtf:MyTextField;
      
      private var xgnum:MyTextField;
      
      private var btnVec:Vector.<Button> = new Vector.<Button>();
      
      private var btnx:Array = [537,89,579,131,579,235];
      
      private var btny:Array = [362,315,267,216,169,121];
      
      private var sprArr:Vector.<sp222> = new Vector.<sp222>();
      
      public function ShengDanPanel()
      {
         super();
         regResource("lang/ch/HZXuFei_Imgs.swf","HZXuFei_Imgsdm");
      }
      
      private function onAskSceneOkHd() : void
      {
         ShengDanUtil.checkSceneToPlay();
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         var tf:MyTextField;
         var i:int;
         var j:int;
         var vo:Vo_item = null;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":747,
            "height":536
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":41,
            "width":697,
            "height":486
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":712,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.close);
         ComponentUtil.getBitmap("Title_HZHL",this,{
            "x":293,
            "y":5
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":404,
            "width":673,
            "height":65
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Back_HZHL",this,{
            "x":37,
            "y":52
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_ZiSe",this,{
            "x":82,
            "y":152
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_LvSe",this,{
            "x":40,
            "y":251
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_LanSe",this,{
            "x":506,
            "y":203
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_HuangSe",this,{
            "x":186,
            "y":57
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_ChengSe",this,{
            "x":506,
            "y":105
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getBitmap("Box_BaiSe",this,{
            "x":464,
            "y":298
         },Global.HZXuFei_Imgsdm);
         ComponentUtil.getTextField("活动时间：",this,{
            "x":46,
            "y":411,
            "color":327424,
            "size":12,
            "leading":3
         });
         ComponentUtil.getTextField("活动规则：",this,{
            "x":46,
            "y":430,
            "color":327424,
            "size":12,
            "leading":3
         });
         this.timetf = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":411,
            "color":327424,
            "size":12,
            "leading":4
         });
         this.xgnum = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":411,
            "color":14662240,
            "size":12,
            "leading":4
         });
         this.xgnum.htmlText = LangConfig.getWord("60500",6);
         tf = ComponentUtil.getTextField("",this,{
            "x":100,
            "y":430,
            "color":14662240,
            "size":12,
            "leading":4
         });
         tf.multiline = true;
         tf.htmlText = "<font color = \'#04ff00\'>必须在本页面开通/续费黄钻特权，活动期间每人可以免费领取一个礼包。挂的越高的礼包奖励越丰富，每个礼包<br>限领1次</font><font color = \'#ff0000\'>（特别提示：领奖条件是按照续费次数而非月份计算，建议每次开通续费1个月）</font>";
         this.btnHaoYou = ComponentUtil.getButton("","Button_HYKT",this,{
            "x":462,
            "y":479,
            "textColor":16771436
         },Global.HZXuFei_Imgsdm);
         this.btnKaiTong = ComponentUtil.getButton("","Button_YellowKT",this,{
            "x":158,
            "y":479,
            "textColor":16771436
         },Global.HZXuFei_Imgsdm);
         this.btnXuFei = ComponentUtil.getButton("","Button_YellowXF",this,{
            "x":158,
            "y":479,
            "textColor":16184781
         },Global.HZXuFei_Imgsdm);
         this.btnKaiTong.callBack = this.btnXuFei.callBack = this.KTXFHd;
         this.btnHaoYou.callBack = function(e:MouseEvent):void
         {
            View_hzTribute.sendType = "send";
            YellowDiaManager.buy();
         };
         i = 0;
         while(i < 6)
         {
            this.btnVec[i] = ComponentUtil.getButton("","Button_Get",this,{
               "x":this.btnx[i],
               "y":this.btny[i],
               "textColor":16184781
            },Global.HZXuFei_Imgsdm);
            this.btnVec[i].addEventListener(MouseEvent.CLICK,this.btnClick);
            i++;
         }
         this.yellowIndex = ComponentUtil.getTextField("",this,{
            "x":637,
            "y":60,
            "color":16776960,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("当前已开通/续费",this,{
            "x":530,
            "y":60,
            "color":16777215,
            "size":14,
            "leading":0
         });
         j = 0;
         while(j < 6)
         {
            this.sprArr[j] = new sp222();
            this.sprArr[j].graphics.beginFill(65535,0);
            if(j == 0)
            {
               this.sprArr[j].graphics.drawRect(this.btnVec[j].x - 60 + 25,this.btnVec[j].y - 55,50,50);
            }
            else
            {
               this.sprArr[j].graphics.drawRect(this.btnVec[j].x - 60,this.btnVec[j].y - 55,50,50);
            }
            addChild(this.sprArr[j]);
            vo = new Vo_item();
            vo.id = 44612 + j;
            vo.Init_lib();
            this.sprArr[j].setVo(vo);
            j++;
         }
      }
      
      private function KTXFHd(e:MouseEvent) : void
      {
         View_hzTribute.sendType = "self";
         YellowDiaManager.buy();
      }
      
      private function cbSelectedHd(delay:int) : void
      {
         ShengDanUtil.selectedDelay = delay;
         ShengDanUtil.checkSceneToPlay();
      }
      
      private function close(e:MouseEvent) : void
      {
         visible = false;
      }
      
      public function Open() : void
      {
         this.yellowIndex.text = ShengDanVO.yellowIndex.toString() + "次黄钻";
         if(ShengDanVO.endTime > 999)
         {
            this.timetf.text = ShengDanVO.starTime.toString().slice(0,4) + "年" + ShengDanVO.starTime.toString().slice(4,6) + "月" + ShengDanVO.starTime.toString().slice(6,8) + "日00:00:00至" + ShengDanVO.endTime.toString().slice(0,2) + "月" + ShengDanVO.endTime.toString().slice(2,4) + "日23:59:59";
         }
         else
         {
            this.timetf.text = ShengDanVO.starTime.toString().slice(0,4) + "年" + ShengDanVO.starTime.toString().slice(4,6) + "月" + ShengDanVO.starTime.toString().slice(6,8) + "日00:00:00至0" + ShengDanVO.endTime.toString().slice(0,1) + "月" + ShengDanVO.endTime.toString().slice(1,3) + "日23:59:59";
         }
         this.arrVO = [ShengDanVO.btn1,ShengDanVO.btn2,ShengDanVO.btn3,ShengDanVO.btn4,ShengDanVO.btn5,ShengDanVO.btn6];
         if(Boolean(ShengDanVO.isyellow))
         {
            this.btnXuFei.visible = true;
            this.btnKaiTong.visible = false;
         }
         else
         {
            this.btnXuFei.visible = false;
            this.btnKaiTong.visible = true;
         }
         var i:int = 0;
         while(i < 6)
         {
            switch(this.arrVO[i])
            {
               case 0:
                  this.btnVec[i].style = "Button_Get";
                  this.btnVec[i].enabled = false;
                  break;
               case 1:
                  this.btnVec[i].style = "Button_Get";
                  this.btnVec[i].enabled = true;
                  break;
               case 2:
                  this.btnVec[i].style = "Button_Goted";
                  this.btnVec[i].enabled = false;
            }
            i++;
         }
         this.getistime();
      }
      
      private function getistime() : void
      {
         switch(ShengDanVO.istime)
         {
            case 1:
               this.xgnum.visible = false;
               this.timetf.visible = true;
               break;
            case 2:
               this.timetf.visible = false;
               this.xgnum.visible = true;
         }
      }
      
      private function btnClick(e:MouseEvent) : void
      {
         switch(e.target)
         {
            case this.btnVec[0]:
               ShengDanCGMessage.CG_SHENGDAN_GET(1);
               break;
            case this.btnVec[1]:
               ShengDanCGMessage.CG_SHENGDAN_GET(2);
               break;
            case this.btnVec[2]:
               ShengDanCGMessage.CG_SHENGDAN_GET(3);
               break;
            case this.btnVec[3]:
               ShengDanCGMessage.CG_SHENGDAN_GET(4);
               break;
            case this.btnVec[4]:
               ShengDanCGMessage.CG_SHENGDAN_GET(5);
               break;
            case this.btnVec[5]:
               ShengDanCGMessage.CG_SHENGDAN_GET(6);
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.yiTian.Global;
import com.yiTian.manager.TipManager;
import flash.display.Sprite;
import flash.events.MouseEvent;

class sp222 extends Sprite
{
   
   private var _vo:Object;
   
   public function sp222()
   {
      super();
   }
   
   public function setVo(obj:Object) : void
   {
      this._vo = obj;
      addEventListener(MouseEvent.ROLL_OVER,function(e:*):void
      {
         TipManager.update(_vo);
         TipManager.getItView().x = Global.stage.mouseX;
         TipManager.getItView().y = Global.stage.mouseY;
      });
      addEventListener(MouseEvent.ROLL_OUT,function(e:*):void
      {
         TipManager.hide();
      });
   }
}
